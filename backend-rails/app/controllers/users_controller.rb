class UsersController < ApplicationController
  # API-only Rails não usa CSRF protection
  require 'base64'

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
    # Validar parâmetros obrigatórios
    return render json: { error: "Email é obrigatório" }, status: :bad_request unless params[:email].present?
    return render json: { error: "Email é obrigatório" }, status: :bad_request unless params[:email].present?
    return render json: { error: "Nome é obrigatório" }, status: :bad_request unless params[:name].present?
    return render json: { error: "Username é obrigatório" }, status: :bad_request unless params[:username].present?
    return render json: { error: "Senha é obrigatória" }, status: :bad_request unless params[:password].present?
    return render json: { error: "Senha deve ter pelo menos 8 caracteres" }, status: :bad_request if params[:password].length < 8
    
    user = User.new(user_params)

    if user.save
      render json: { 
        message: "Usuário criado com sucesso", 
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          name: user.name,
          user_type: user.user_type,
          account_type: user.account_type || 'normal'
        }
      }, status: :created
    else
      render json: { error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def login
    return render json: { error: "Email é obrigatório" }, status: :bad_request unless params[:email].present?
    return render json: { error: "Senha é obrigatória" }, status: :bad_request unless params[:password].present?
    
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user && user.authenticate(params[:password])
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
      render json: { error: "Email ou senha inválidos" }, status: :unauthorized
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
    permitted = params.permit(:email, :password, :password_confirmation, :username, :name, :user_type)
    
    # Formatar nome (capitalizado) e username (minúsculo)
    permitted[:name] = permitted[:name].titleize if permitted[:name].present?
    permitted[:username] = permitted[:username].downcase if permitted[:username].present?
    
    permitted
  end
  
  def update_user_params
    permitted = params.permit(:username, :name, :user_type, :profile_picture)
    
    # Formatar nome (capitalizado) e username (minúsculo)
    permitted[:name] = permitted[:name].titleize if permitted[:name].present?
    permitted[:username] = permitted[:username].downcase if permitted[:username].present?
    
    permitted
  end
end
