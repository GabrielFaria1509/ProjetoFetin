class ContentsController < ApplicationController
  def index
    @contents = Content.published.order(published_at: :desc)
    @contents = @contents.by_category(params[:category]) if params[:category].present?
    
    render json: @contents
  end

  def show
    @content = Content.find(params[:id])
    render json: @content
  end
end