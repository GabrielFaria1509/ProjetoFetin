class ForumsController < ApplicationController
  def index
    render json: Forum.all
  end

  def show
    forum = Forum.find(params[:id])
    posts = forum.posts.includes(:user)
    render json: { forum: forum, posts: posts.as_json(include: :user) }
  end

  def create
    forum = Forum.new(params.permit(:title, :description, :user_id))
    if forum.save
      render json: forum, status: :created
    else
      render json: forum.errors, status: :unprocessable_entity
    end
  end
end
