class ProfileController < ApplicationController
  def update_name
    user = User.find_by(id: params[:id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    return render json: { error: "Nome é obrigatório" }, status: :bad_request unless params[:name].present?
    
    # Verificar cooldown
    if user.name_updated_at && user.name_updated_at > 1.day.ago
      return render json: { error: "Nome pode ser alterado apenas 1 vez por dia" }, status: :unprocessable_entity
    end
    
    # Atualizar diretamente no banco
    User.where(id: user.id).update_all(
      name: params[:name].titleize,
      name_updated_at: Time.current
    )
    
    user.reload
    
    render json: {
      message: "Nome atualizado com sucesso",
      user: {
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        user_type: user.user_type
      }
    }, status: :ok
  end
  
  def update_username
    user = User.find_by(id: params[:id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    return render json: { error: "Username é obrigatório" }, status: :bad_request unless params[:username].present?
    
    # Verificar cooldown
    if user.username_updated_at && user.username_updated_at > 3.days.ago
      return render json: { error: "Username pode ser alterado apenas 1 vez a cada 3 dias" }, status: :unprocessable_entity
    end
    
    # Verificar se username já existe
    existing_user = User.where.not(id: user.id).find_by(username: params[:username].downcase)
    if existing_user
      return render json: { error: "Este username já está em uso" }, status: :unprocessable_entity
    end
    
    # Atualizar diretamente no banco
    User.where(id: user.id).update_all(
      username: params[:username].downcase,
      username_updated_at: Time.current
    )
    
    user.reload
    
    render json: {
      message: "Username atualizado com sucesso",
      user: {
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        user_type: user.user_type
      }
    }, status: :ok
  end
  
  def update_user_type
    user = User.find_by(id: params[:id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    return render json: { error: "Tipo de usuário é obrigatório" }, status: :bad_request unless params[:user_type].present?
    
    unless ['Responsável', 'Profissional'].include?(params[:user_type])
      return render json: { error: "Tipo de usuário inválido" }, status: :bad_request
    end
    
    # Atualizar diretamente no banco
    User.where(id: user.id).update_all(user_type: params[:user_type])
    
    user.reload
    
    render json: {
      message: "Tipo de usuário atualizado com sucesso",
      user: {
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        user_type: user.user_type
      }
    }, status: :ok
  end
end