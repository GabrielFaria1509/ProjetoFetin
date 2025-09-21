class FirebaseAuthService
  require 'net/http'
  require 'json'
  
  def self.verify_user(email, password)
    api_key = ENV['FIREBASE_API_KEY']
    return nil unless api_key.present?
    
    begin
      # Primeiro fazer login para obter o idToken
      uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=#{api_key}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.read_timeout = 10
      http.open_timeout = 10
      
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = {
        email: email,
        password: password,
        returnSecureToken: true
      }.to_json
      
      response = http.request(request)
      
      return nil unless response.code == '200'
      
      login_data = JSON.parse(response.body)
      id_token = login_data['idToken']
      
      # Agora buscar dados atualizados do usuário
      user_uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=#{api_key}")
      user_http = Net::HTTP.new(user_uri.host, user_uri.port)
      user_http.use_ssl = true
      
      user_request = Net::HTTP::Post.new(user_uri)
      user_request['Content-Type'] = 'application/json'
      user_request.body = {
        idToken: id_token
      }.to_json
      
      user_response = user_http.request(user_request)
      
      return nil unless user_response.code == '200'
      
      user_data = JSON.parse(user_response.body)
      user_info = user_data['users']&.first
      
      return nil unless user_info
      
      # Verificar se email foi verificado
      if user_info['emailVerified'] == true
        {
          uid: user_info['localId'],
          email: user_info['email'],
          email_verified: true,
          display_name: user_info['displayName']
        }
      else
        nil
      end
      
    rescue Net::TimeoutError, Net::OpenTimeout
      Rails.logger.error "Firebase timeout for email: #{email}"
      nil
    rescue JSON::ParserError => e
      Rails.logger.error "Firebase JSON parse error: #{e.message}"
      nil
    rescue => e
      Rails.logger.error "Firebase verification error: #{e.message}"
      nil
    end
  end
end