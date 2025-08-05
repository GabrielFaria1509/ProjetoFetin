require 'net/http'
require 'json'

class ChatbotController < ApplicationController
  before_action :set_headers
  
  def chat
    user_input = params[:message]
    return render json: { error: 'Mensagem obrigatória' }, status: 400 if user_input.blank?
    
    response = get_ai_response(user_input)
    
    render json: {
      message: response,
      timestamp: Time.current.iso8601
    }
  rescue => e
    render json: { error: 'Erro interno do servidor' }, status: 500
  end
  
  private
  
  def get_ai_response(user_input)
    # Tenta API primeiro, fallback se falhar
    api_response = call_huggingface_api(user_input)
    return api_response if api_response
    
    get_fallback_response(user_input)
  end
  
  def call_huggingface_api(user_input)
    uri = URI('https://api-inference.huggingface.co/models/microsoft/DialoGPT-medium')
    
    payload = {
      inputs: "#{system_prompt}\n\nUsuário: #{user_input}\nChatbot:",
      parameters: {
        max_new_tokens: 100,
        temperature: 0.7,
        return_full_text: false
      }
    }.to_json
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 10
    
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{ENV['HUGGINGFACE_TOKEN']}"
    request['Content-Type'] = 'application/json'
    request.body = payload
    
    response = http.request(request)
    
    if response.code == '200'
      result = JSON.parse(response.body)
      result.first['generated_text']&.strip
    end
  rescue
    nil
  end
  
  def get_fallback_response(user_input)
    keywords = {
      'comportamento' => 'É normal que crianças autistas tenham comportamentos diferentes. O importante é observar padrões e oferecer rotina.',
      'escola' => 'A inclusão escolar funciona melhor com comunicação entre família e escola. Converse com os professores.',
      'comunicação' => 'Cada criança se comunica de forma única. Algumas usam gestos, outras precisam de mais tempo.',
      'rotina' => 'Rotinas claras ajudam muito. Use calendários visuais e prepare para mudanças.',
      'crise' => 'Durante crises, mantenha a calma, ofereça ambiente seguro e evite muitos estímulos.'
    }
    
    keywords.each do |keyword, response|
      return response if user_input.downcase.include?(keyword)
    end
    
    'Entendo sua preocupação. Cada situação é única. Pode me dar mais detalhes para ajudar melhor?'
  end
  
  def system_prompt
    'Você é um chatbot especialista em autismo. Oriente pais e professores com empatia, linguagem simples e respeitosa. Evite termos técnicos. Fale em português claro.'
  end
  
  def set_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end
end