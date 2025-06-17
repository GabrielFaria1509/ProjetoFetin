class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params)

    if user.save
      render json: { message: "Usuário criado com sucesso", user: user }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: { message: "Login realizado com sucesso", user: user }, status: :ok
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

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :name)
  end
end
