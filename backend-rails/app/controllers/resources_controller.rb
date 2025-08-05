class ResourcesController < ApplicationController
  def index
    @resources = Resource.all
    @resources = @resources.where(category: params[:category]) if params[:category].present?
    @resources = @resources.where(resource_type: params[:type]) if params[:type].present?
    
    render json: @resources
  end

  def show
    @resource = Resource.find(params[:id])
    render json: @resource
  end
end