class AdminController < ApplicationController
  before_action :authenticate_admin

  # Admin Login
  def login
    return render json: { error: 'Chave de administrador inválida' }, status: :unauthorized unless params[:admin_key] == ENV['ADMIN_KEY']
    
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      token = generate_admin_token(user)
      render json: { 
        message: 'Login administrativo realizado com sucesso',
        user: user_data(user),
        token: token
      }, status: :ok
    else
      render json: { error: 'Credenciais inválidas' }, status: :unauthorized
    end
  end

  # Users Management
  def users_index
    users = User.all.order(created_at: :desc)
    render json: {
      users: users.map { |user| user_data(user) }
    }, status: :ok
  end

  def users_update
    user = User.find(params[:id])
    
    if user.update(admin_user_params)
      render json: { 
        message: 'Usuário atualizado com sucesso',
        user: user_data(user)
      }, status: :ok
    else
      render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def users_destroy
    user = User.find(params[:id])
    
    if user.destroy
      render json: { message: 'Usuário deletado com sucesso' }, status: :ok
    else
      render json: { error: 'Erro ao deletar usuário' }, status: :unprocessable_entity
    end
  end

  # Posts Management
  def posts_index
    posts = Post.joins(:user)
                .select('posts.*, users.name as author, users.username, users.account_type')
                .order(created_at: :desc)
    
    render json: {
      posts: posts.map do |post|
        {
          id: post.id,
          content: post.content,
          author: post.author || post.username,
          username: post.username,
          account_type: post.account_type || 'normal',
          created_at: post.created_at,
          likes_count: post.likes_count || 0,
          comments_count: post.comments_count || 0
        }
      end
    }, status: :ok
  end

  def posts_destroy
    post = Post.find(params[:id])
    
    if post.destroy
      render json: { message: 'Post deletado com sucesso' }, status: :ok
    else
      render json: { error: 'Erro ao deletar post' }, status: :unprocessable_entity
    end
  end

  # Articles Management
  def articles_index
    articles = Content.all.order(created_at: :desc)
    
    render json: {
      articles: articles.map do |article|
        {
          id: article.id,
          title: article.title,
          body: article.body,
          category: article.category,
          author: article.author,
          image_url: article.image_url,
          published_at: article.published_at,
          created_at: article.created_at
        }
      end
    }, status: :ok
  end

  def articles_create
    article = Content.new(admin_article_params)
    
    if article.save
      render json: { 
        message: 'Artigo criado com sucesso',
        article: article
      }, status: :created
    else
      render json: { error: article.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def articles_update
    article = Content.find(params[:id])
    
    if article.update(admin_article_params)
      render json: { 
        message: 'Artigo atualizado com sucesso',
        article: article
      }, status: :ok
    else
      render json: { error: article.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def articles_destroy
    article = Content.find(params[:id])
    
    if article.destroy
      render json: { message: 'Artigo deletado com sucesso' }, status: :ok
    else
      render json: { error: 'Erro ao deletar artigo' }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_admin
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Token não fornecido' }, status: :unauthorized unless token
    
    # Verificação simples do token (em produção, use JWT)
    return render json: { error: 'Token inválido' }, status: :unauthorized unless valid_admin_token?(token)
  end

  def generate_admin_token(user)
    "admin_#{user.id}_#{Time.current.to_i}"
  end

  def valid_admin_token?(token)
    token.start_with?('admin_') && token.split('_').length == 3
  end

  def user_data(user)
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

  def admin_user_params
    params.permit(:name, :username, :email, :user_type, :account_type)
  end

  def admin_article_params
    params.permit(:title, :body, :category, :author, :image_url, :published_at)
  end
end