class PostsController < ApplicationController
  def index
    posts = Post.includes(:user, :likes, :reactions).order(created_at: :desc)
    current_user_id = params[:user_id]&.to_i # Passar user_id na query
    
    render json: {
      posts: posts.map do |post|
        {
          id: post.id,
          content: post.content,
          author: post.user.name || post.user.username,
          username: post.user.username,
          timestamp: post.created_at,
          likes: post.likes.count,
          comments: post.comments_count || 0,
          isLiked: current_user_id ? post.likes.exists?(user_id: current_user_id) : false,
          isSaved: false, # TODO: implementar saves
          tags: post.tags || [],
          reaction_counts: post.reaction_counts,
          user_reaction: current_user_id ? post.reactions.find_by(user_id: current_user_id)&.reaction_type : nil
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
    
    user = User.find_by(id: params[:user_id])
    return render json: { error: "Usuário não encontrado" }, status: :not_found unless user
    
    like = post.likes.find_by(user: user)
    
    if like
      # Descurtir
      like.destroy
      post.decrement!(:likes_count) if post.likes_count > 0
      render json: { message: "Post descurtido", liked: false, likes_count: post.likes.count }, status: :ok
    else
      # Curtir
      post.likes.create!(user: user)
      post.increment!(:likes_count)
      render json: { message: "Post curtido", liked: true, likes_count: post.likes.count }, status: :ok
    end
  end

  def save_post
    return render json: { error: "User ID é obrigatório" }, status: :bad_request unless params[:user_id].present?
    
    post = Post.find_by(id: params[:id])
    return render json: { error: "Post não encontrado" }, status: :not_found unless post
    
    render json: { message: "Post salvo com sucesso" }, status: :ok
  end
end