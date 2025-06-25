class CommentsController < ApplicationController
  def create
    comment = Comment.new(params.permit(:content, :post_id, :user_id))
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end
end
