class ForumPostsController < ApplicationController
  def index
    posts = UserPost.joins(:user, :forum)
                   .select('user_posts.*, users.username, users.name, users.account_type,
                           COUNT(DISTINCT comments.id) as comments_count')
                   .left_joins(:comments)
                   .group('user_posts.id, users.username, users.name, users.account_type')
                   .order(created_at: :desc)
    
    render json: posts.map { |post|
      {
        id: post.id,
        content: post.content,
        author: post.name || post.username,
        username: post.username,
        account_type: post.account_type || 'normal',
        created_at: post.created_at,
        likes_count: 0,
        comments_count: post.comments_count || 0,
        is_liked: false
      }
    }
  end

  def create
    user = User.find_by(id: params[:user_id])
    return render json: { error: 'Usuário não encontrado' }, status: :not_found unless user
    
    return render json: { error: 'Conteúdo é obrigatório' }, status: :bad_request if params[:content].blank?
    
    forum = Forum.first
    unless forum
      forum = Forum.create!(
        name: 'Fórum Geral',
        description: 'Fórum principal da comunidade TEA',
        user: user
      )
    end
    
    post = UserPost.new(
      title: params[:content].truncate(50),
      content: params[:content],
      user: user,
      forum: forum
    )
    
    if post.save
      render json: { 
        message: 'Post criado com sucesso',
        post: {
          id: post.id,
          content: post.content,
          username: user.username,
          created_at: post.created_at
        }
      }, status: :created
    else
      render json: { error: post.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def toggle_like
    render json: { message: 'Like atualizado' }, status: :ok
  end

  def comments
    post = UserPost.find_by(id: params[:id])
    return render json: { error: 'Post não encontrado' }, status: :not_found unless post
    
    comments = post.comments.joins(:user)
                          .select('comments.*, users.username, users.name, users.account_type')
                          .order(created_at: :desc)
    
    render json: comments.map { |comment|
      {
        id: comment.id,
        content: comment.content,
        author: comment.name || comment.username,
        username: comment.username,
        account_type: comment.account_type || 'normal',
        created_at: comment.created_at
      }
    }
  end

  def create_comment
    post = UserPost.find_by(id: params[:id])
    return render json: { error: 'Post não encontrado' }, status: :not_found unless post
    
    user = User.find_by(id: params[:user_id])
    return render json: { error: 'Usuário não encontrado' }, status: :not_found unless user
    
    comment = Comment.new(
      content: params[:content],
      user_post: post,
      user: user
    )
    
    if comment.save
      render json: { message: 'Comentário criado com sucesso' }, status: :created
    else
      render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end