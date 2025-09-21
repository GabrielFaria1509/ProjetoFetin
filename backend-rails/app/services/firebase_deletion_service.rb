class FirebaseDeletionService
  require 'net/http'
  require 'json'
  
  def self.delete_user(firebase_uid)
    api_key = ENV['FIREBASE_API_KEY']
    return true unless api_key.present? && firebase_uid.present? # Continuar se não tiver dados
    
    begin
      # Buscar usuário para obter email e senha
      user = User.find_by(firebase_uid: firebase_uid)
      return true unless user # Continuar se não encontrar
      
      # Fazer login para obter idToken
      login_uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=#{api_key}")
      http = Net::HTTP.new(login_uri.host, login_uri.port)
      http.use_ssl = true
      http.read_timeout = 10
      
      # Tentar fazer login com a senha original (não o hash)
      login_request = Net::HTTP::Post.new(login_uri)
      login_request['Content-Type'] = 'application/json'
      login_request.body = {
        email: user.email,
        password: user.password, # Senha original se disponível
        returnSecureToken: true
      }.to_json
      
      login_response = http.request(login_request)
      
      if login_response.code == '200'
        login_data = JSON.parse(login_response.body)
        id_token = login_data['idToken']
        
        # Deletar conta com idToken
        delete_uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:delete?key=#{api_key}")
        delete_request = Net::HTTP::Post.new(delete_uri)
        delete_request['Content-Type'] = 'application/json'
        delete_request.body = {
          idToken: id_token
        }.to_json
        
        delete_response = http.request(delete_request)
        
        if delete_response.code == '200'
          Rails.logger.info "Firebase user deleted: #{firebase_uid}"
        else
          Rails.logger.warn "Firebase deletion failed: #{delete_response.body}"
        end
      else
        Rails.logger.warn "Firebase login failed for deletion: #{login_response.body}"
      end
      
      # Sempre retornar true para continuar com deleção do DB
      true
      
    rescue => e
      Rails.logger.error "Firebase deletion error: #{e.message}"
      # Sempre continuar com deleção do DB mesmo se Firebase falhar
      true
    end
  end
end