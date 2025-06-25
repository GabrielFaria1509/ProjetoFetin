class UserPostsController < ApplicationController
  def show
    post = Post.find(params[:id])
    comments = post.comments.includes(:user)
    render json: { post: post, comments: comments.as_json(include: :user) }
  end

  def create
    post = Post.new(params.permit(:title, :content, :forum_id, :user_id))
    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end
end
