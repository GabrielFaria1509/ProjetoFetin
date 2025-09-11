class CommentsController < ApplicationController
  def index
    post = Post.find_by(id: params[:post_id])
    return render json: { error: "Post não encontrado" }, status: :not_found unless post
    
    comments = post.comments.includes(:user).order(created_at: :asc)
    
    render json: {
      comments: comments.map do |comment|
        {
          id: comment.id,
          content: comment.content,
          author: comment.user.name || comment.user.username,
          username: comment.user.username,
          timestamp: comment.created_at
        }
      end
    }, status: :ok
  end

  def create
    return render json: { error: "User ID é obrigatório" }, status: :bad_request unless params[:user_id].present?
    return render json: { error: "Conteúdo é obrigatório" }, status: :bad_request unless params[:content].present?
    
    post = Post.find_by(id: params[:post_id])
    return render json: { error: "Post não encontrado" }, status: :not_found unless post
    
    user = User.find_by(id: params[:user_id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    
    # Verificar se tabela comments existe
    unless ActiveRecord::Base.connection.table_exists?('comments')
      return render json: { error: "Sistema de comentários em manutenção" }, status: :service_unavailable
    end
    
    comment = Comment.new(
      post: post,
      user: user,
      content: params[:content].strip
    )

    if comment.save
      # Atualizar contador de comentários
      Post.where(id: post.id).update_all(comments_count: post.comments.count)
      
      render json: {
        message: "Comentário criado com sucesso",
        comment: {
          id: comment.id,
          content: comment.content,
          author: comment.user.name || comment.user.username,
          username: comment.user.username,
          timestamp: comment.created_at
        }
      }, status: :created
    else
      render json: { error: comment.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end
end