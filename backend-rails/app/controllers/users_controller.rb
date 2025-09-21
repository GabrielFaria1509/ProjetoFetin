class UsersController < ApplicationController
  # API-only Rails não usa CSRF protection
  require 'base64'
  require 'securerandom'

  def index
    users = User.all.order(created_at: :desc)
    render json: {
      users: users.map do |user|
        {
          id: user.id,
          name: user.name,
          username: user.username,
          email: user.email,
          user_type: user.user_type,
          account_type: user.account_type || 'normal',
          created_at: user.created_at
        }
      end
    }, status: :ok
  end

  def create
    # Rate limiting
    if SecurityService.rate_limit_exceeded?(request.remote_ip, :signup)
      return render json: { error: "Muitas tentativas. Tente novamente mais tarde" }, status: :too_many_requests
    end
    
    # Validar parâmetros obrigatórios
    return render json: { error: "Email é obrigatório" }, status: :bad_request unless params[:email].present?
    return render json: { error: "Nome é obrigatório" }, status: :bad_request unless params[:name].present?
    return render json: { error: "Username é obrigatório" }, status: :bad_request unless params[:username].present?
    return render json: { error: "Senha é obrigatória" }, status: :bad_request unless params[:password].present?
    
    # Validar dados com segurança
    security_errors = SecurityService.validate_user_data(params)
    return render json: { error: security_errors.first }, status: :bad_request if security_errors.any?
    
    # Criar conta no Firebase
    firebase_result = FirebaseSignupService.create_user(params[:email], params[:password])
    
    unless firebase_result[:success]
      return render json: { error: firebase_result[:error] }, status: :unprocessable_entity
    end
    
    # Criar usuário no banco local com senha real
    user = User.new(
      email: firebase_result[:email].downcase,
      firebase_uid: firebase_result[:firebase_uid],
      name: SecurityService.sanitize_input(params[:name]).titleize,
      username: SecurityService.sanitize_input(params[:username]).downcase,
      user_type: params[:user_type] || 'Responsável',
      account_type: 'normal',
      password: params[:password], # Senha real para login posterior
      email_verified: false
    )
    
    if user.save
      # Retornar 202 para indicar que precisa verificar email
      render json: { 
        message: "Conta criada! Verifique seu email para ativar", 
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          name: user.name,
          user_type: user.user_type,
          account_type: user.account_type
        },
        email_sent: firebase_result[:email_sent]
      }, status: 202 # Accepted - precisa verificar email
    else
      render json: { error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def login
    return render json: { error: "Email é obrigatório" }, status: :bad_request unless params[:email].present?
    return render json: { error: "Senha é obrigatória" }, status: :bad_request unless params[:password].present?
    
    # Buscar APENAS usuário existente - NÃO criar novo
    user = User.find_by(email: params[:email].to_s.strip.downcase)
    
    # Se não encontrar, retornar erro
    unless user
      return render json: { error: "Conta não encontrada. Faça seu cadastro primeiro." }, status: :unauthorized
    end
    
    # Verificar se email foi verificado (se usar Firebase)
    if user.firebase_uid.present? && !user.email_verified
      return render json: { error: "Verifique seu email antes de fazer login" }, status: :unauthorized
    end

    if user.authenticate(params[:password])
      # Atualizar último login
      user.update(last_login_at: Time.current)
      
      render json: { 
        message: "Login realizado com sucesso", 
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          name: user.name,
          user_type: user.user_type,
          account_type: user.account_type || 'normal',
          profile_picture: user.profile_picture
        }
      }, status: :ok
    else
      render json: { error: "Senha incorreta" }, status: :unauthorized
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    
    if user.destroy
      render json: { message: "Usuário deletado com sucesso" }, status: :ok
    else
      render json: { error: "Erro ao deletar usuário" }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find_by(id: params[:id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    
    # Verificar cooldowns apenas para nome e username
    if params[:name].present?
      if user.name_updated_at && user.name_updated_at > 1.day.ago
        return render json: { error: "Nome pode ser alterado apenas 1 vez por dia" }, status: :unprocessable_entity
      end
      user.name_updated_at = Time.current
    end
    
    if params[:username].present?
      if user.username_updated_at && user.username_updated_at > 3.days.ago
        return render json: { error: "Username pode ser alterado apenas 1 vez a cada 3 dias" }, status: :unprocessable_entity
      end
      user.username_updated_at = Time.current
    end
    
    # Atualizar normalmente - password não é mais obrigatório no update
    if user.update(update_user_params)
      render json: {
        message: "Usuário atualizado com sucesso",
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          name: user.name,
          user_type: user.user_type,
          account_type: user.account_type || 'normal',
          profile_picture: user.profile_picture
        }
      }, status: :ok
    else
      render json: { error: "Erro ao atualizar usuário" }, status: :unprocessable_entity
    end
  end

  def check_verification
    return render json: { error: "Email é obrigatório" }, status: :bad_request unless params[:email].present?
    
    user = User.find_by(email: params[:email].to_s.strip.downcase)
    
    unless user
      return render json: { verified: false, error: "Usuário não encontrado" }, status: :not_found
    end
    
    # Simular verificação - em produção, verificaria com Firebase
    # Por enquanto, marcar como verificado após 10 segundos da criação
    if user.created_at < 10.seconds.ago
      user.update(email_verified: true)
      render json: { verified: true, user: {
        id: user.id,
        username: user.username,
        email: user.email,
        name: user.name,
        user_type: user.user_type,
        account_type: user.account_type
      }}, status: :ok
    else
      render json: { verified: false, message: "Email ainda não verificado" }, status: :ok
    end
  end

  def upload_avatar
    user = User.find_by(id: params[:id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    
    if params[:avatar_base64].present?
      base64_image = "data:image/jpeg;base64,#{params[:avatar_base64]}"
      user.profile_picture = base64_image
      
      if user.save
        render json: { 
          message: "Avatar atualizado com sucesso",
          avatar_url: base64_image
        }, status: :ok
      else
        render json: { error: "Erro ao salvar avatar" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Nenhuma imagem enviada" }, status: :bad_request
    end
  end

  private

  def user_params
    permitted = params.permit(:email, :password, :password_confirmation, :username, :name, :user_type, :firebase_uid, :account_type)
    
    # Formatar nome (capitalizado) e username (minúsculo)
    permitted[:name] = permitted[:name].titleize if permitted[:name].present?
    permitted[:username] = permitted[:username].downcase if permitted[:username].present?
    permitted[:email] = permitted[:email].downcase.strip if permitted[:email].present?
    
    # Validar account_type
    permitted[:account_type] = 'normal' unless ['normal', 'verified', 'bot'].include?(permitted[:account_type])
    
    permitted
  end
  
  def update_user_params
    permitted = params.permit(:username, :name, :user_type, :profile_picture, :account_type)
    
    # Formatar nome (capitalizado) e username (minúsculo)
    permitted[:name] = permitted[:name].titleize if permitted[:name].present?
    permitted[:username] = permitted[:username].downcase if permitted[:username].present?
    
    # Validar account_type
    permitted[:account_type] = 'normal' unless ['normal', 'verified', 'bot'].include?(permitted[:account_type])
    
    permitted
  end
end
