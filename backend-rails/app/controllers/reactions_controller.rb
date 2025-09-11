class ReactionsController < ApplicationController
  def create
    return render json: { error: "User ID é obrigatório" }, status: :bad_request unless params[:user_id].present?
    return render json: { error: "Tipo de reação é obrigatório" }, status: :bad_request unless params[:reaction_type].present?
    
    post = Post.find_by(id: params[:post_id])
    return render json: { error: "Post não encontrado" }, status: :not_found unless post
    
    user = User.find_by(id: params[:user_id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    
    unless Reaction::REACTION_TYPES.include?(params[:reaction_type])
      return render json: { error: "Tipo de reação inválido" }, status: :bad_request
    end
    
    # Remove reação existente se houver
    existing_reaction = post.reactions.find_by(user: user)
    
    if existing_reaction
      if existing_reaction.reaction_type == params[:reaction_type]
        # Remove se for a mesma reação
        existing_reaction.destroy
        render json: { 
          message: "Reação removida", 
          reaction_counts: post.reaction_counts,
          user_reaction: nil
        }, status: :ok
      else
        # Atualiza para nova reação
        existing_reaction.update!(reaction_type: params[:reaction_type])
        render json: { 
          message: "Reação atualizada", 
          reaction_counts: post.reaction_counts,
          user_reaction: params[:reaction_type]
        }, status: :ok
      end
    else
      # Cria nova reação
      post.reactions.create!(user: user, reaction_type: params[:reaction_type])
      render json: { 
        message: "Reação adicionada", 
        reaction_counts: post.reaction_counts,
        user_reaction: params[:reaction_type]
      }, status: :created
    end
  end
end