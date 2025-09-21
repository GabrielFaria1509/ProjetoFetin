class FirebaseAuthService
  require 'net/http'
  require 'json'
  
  def self.verify_user(email, password)
    api_key = ENV['FIREBASE_API_KEY']
    return nil unless api_key.present?
    
    begin
      # Fazer login no Firebase
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
      
      data = JSON.parse(response.body)
      
      # Verificar se email foi verificado
      if data['emailVerified'] == true
        {
          uid: data['localId'],
          email: data['email'],
          email_verified: true,
          display_name: data['displayName']
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