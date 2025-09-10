class PostsController < ApplicationController
  def index
    posts = Post.includes(:user).order(created_at: :desc)
    
    render json: {
      posts: posts.map do |post|
        {
          id: post.id,
          content: post.content,
          author: post.user.name || post.user.username,
          username: post.user.username,
          timestamp: post.created_at,
          likes: post.likes_count || 0,
          comments: post.comments_count || 0,
          isLiked: false, # TODO: verificar se usuário curtiu
          isSaved: false, # TODO: verificar se usuário salvou
          tags: post.tags || []
        }
      end
    }, status: :ok
  end

  def create
    return render json: { error: "User ID é obrigatório" }, status: :bad_request unless params[:user_id].present?
    return render json: { error: "Conteúdo é obrigatório" }, status: :bad_request unless params[:content].present?
    
    user = User.find_by(id: params[:user_id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    
    post = Post.new(
      user: user,
      content: params[:content],
      likes_count: 0,
      comments_count: 0
    )

    if post.save
      render json: {
        message: "Post criado com sucesso",
        post: {
          id: post.id,
          content: post.content,
          author: post.user.username,
          timestamp: post.created_at,
          likes: 0,
          comments: 0
        }
      }, status: :created
    else
      render json: { error: post.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def like
    return render json: { error: "User ID é obrigatório" }, status: :bad_request unless params[:user_id].present?
    
    post = Post.find_by(id: params[:id])
    return render json: { error: "Post não encontrado" }, status: :not_found unless post
    
    # Simular toggle de like
    post.increment!(:likes_count)
    
    render json: { message: "Post curtido com sucesso" }, status: :ok
  end

  def save_post
    return render json: { error: "User ID é obrigatório" }, status: :bad_request unless params[:user_id].present?
    
    post = Post.find_by(id: params[:id])
    return render json: { error: "Post não encontrado" }, status: :not_found unless post
    
    render json: { message: "Post salvo com sucesso" }, status: :ok
  end
end