class ContentsController < ApplicationController
  def index
    @contents = Content.published.order(published_at: :desc)
    @contents = @contents.by_category(sanitize_param(params[:category])) if params[:category].present?
    
    render json: @contents
  rescue => e
    render json: { error: "Erro ao buscar conteúdos" }, status: :internal_server_error
  end

  def show
    return render json: { error: "ID é obrigatório" }, status: :bad_request unless params[:id].present?
    
    @content = Content.find(params[:id])
    render json: @content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Conteúdo não encontrado" }, status: :not_found
  rescue => e
    render json: { error: "Erro ao buscar conteúdo" }, status: :internal_server_error
  end

  private

  def sanitize_param(param)
    param.to_s.strip if param.present?
  end
end