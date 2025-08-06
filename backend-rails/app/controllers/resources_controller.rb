class ResourcesController < ApplicationController
  def index
    @resources = Resource.all
    @resources = @resources.where(category: sanitize_param(params[:category])) if params[:category].present?
    @resources = @resources.where(resource_type: sanitize_param(params[:type])) if params[:type].present?
    
    render json: @resources
  rescue => e
    render json: { error: "Erro ao buscar recursos" }, status: :internal_server_error
  end

  def show
    return render json: { error: "ID é obrigatório" }, status: :bad_request unless params[:id].present?
    
    @resource = Resource.find(params[:id])
    render json: @resource
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Recurso não encontrado" }, status: :not_found
  rescue => e
    render json: { error: "Erro ao buscar recurso" }, status: :internal_server_error
  end

  private

  def sanitize_param(param)
    param.to_s.strip if param.present?
  end
end