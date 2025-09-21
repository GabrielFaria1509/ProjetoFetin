class FirebaseAuthService
  require 'net/http'
  require 'json'
  
  def self.verify_user(email, password)
    begin
      api_key = ENV['FIREBASE_API_KEY']
      return nil unless api_key
      
      # Fazer login no Firebase para verificar se email foi verificado
      uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=#{api_key}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = {
        email: email,
        password: password,
        returnSecureToken: true
      }.to_json
      
      response = http.request(request)
      data = JSON.parse(response.body)
      
      if response.code == '200' && data['emailVerified']
        return {
          uid: data['localId'],
          email: data['email'],
          email_verified: data['emailVerified'],
          display_name: data['displayName']
        }
      end
      
      return nil
    rescue => e
      Rails.logger.error "Firebase verification error: #{e.message}"
      return nil
    end
  end
end