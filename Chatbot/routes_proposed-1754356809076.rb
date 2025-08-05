Rails.application.routes.draw do
  post '/api/chat', to: 'chatbot#chat'
  options '/api/chat', to: 'chatbot#options'
end