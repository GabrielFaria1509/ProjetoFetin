class UsersController < ApplicationController
  # API-only Rails não usa CSRF protection
  require 'base64'

  def create
    # Validar parâmetros obrigatórios
    return render json: { error: "Email é obrigatório" }, status: :bad_request unless params[:email].present?
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
          user_type: user.user_type
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
          profile_picture: user.profile_picture
        }
      }, status: :ok
    else
      render json: { error: "Email ou senha inválidos" }, status: :unauthorized
    end
  end

  def destroy
    user = User.find_by(email: params[:email])
    return render json: { error: "Email não informado" }, status: :bad_request unless params[:email].present?
    return render json: { error: "Senha não informada" }, status: :bad_request unless params[:password].present?
    if user && user.destroy
      render json: { message: "Usuário deletado com sucesso" }, status: :ok
    else
      render json: { error: "Usuário não encontrado ou não pôde ser deletado" }, status: :not_found
    end
  end

  def update
    user = User.find_by(id: params[:id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    
    if user.update(update_user_params)
      render json: {
        message: "Usuário atualizado com sucesso",
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          name: user.name,
          user_type: user.user_type,
          profile_picture: user.profile_picture
        }
      }, status: :ok
    else
      render json: { error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def upload_avatar
    user = User.find_by(id: params[:id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    
    if params[:avatar].present?
      # Converter imagem para base64 e salvar no banco
      image_data = params[:avatar].read
      base64_image = "data:#{params[:avatar].content_type};base64,#{Base64.encode64(image_data)}"
      
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
    params.permit(:email, :password, :password_confirmation, :username, :name, :user_type)
  end
  
  def update_user_params
    params.permit(:username, :name, :user_type, :profile_picture)
  end
end
