class HomeController < ApplicationController
  def index
    render json: {
      message: "TISM API - Funcionando!",
      version: "1.0.0",
      status: "online",
      timestamp: Time.current
    }
  end
end