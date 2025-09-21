require 'net/http'
require 'json'

class FirebaseSignupService
  FIREBASE_SIGNUP_URL = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp'
  FIREBASE_VERIFY_EMAIL_URL = 'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode'
  
  def self.create_user(email, password)
    api_key = ENV['FIREBASE_API_KEY']
    return { success: false, error: 'Firebase não configurado' } unless api_key.present?
    
    # Validações
    return { success: false, error: 'Email inválido' } unless valid_email?(email)
    return { success: false, error: 'Senha deve ter pelo menos 8 caracteres' } if password.length < 8
    
    begin
      uri = URI("#{FIREBASE_SIGNUP_URL}?key=#{api_key}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.read_timeout = 15
      http.open_timeout = 10
      
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = {
        email: email,
        password: password,
        returnSecureToken: true
      }.to_json
      
      response = http.request(request)
      data = JSON.parse(response.body)
      
      if response.code == '200'
        # Enviar email de verificação
        verification_sent = send_verification_email(data['idToken'])
        
        {
          success: true,
          firebase_uid: data['localId'],
          email: data['email'],
          token: data['idToken'],
          email_sent: verification_sent
        }
      else
        error_msg = case data.dig('error', 'message')
                   when 'EMAIL_EXISTS' then 'Este email já está em uso'
                   when 'WEAK_PASSWORD' then 'Senha muito fraca'
                   when 'INVALID_EMAIL' then 'Email inválido'
                   else 'Erro ao criar conta no Firebase'
                   end
        
        { success: false, error: error_msg }
      end
      
    rescue Net::TimeoutError, Net::OpenTimeout
      { success: false, error: 'Timeout na conexão com Firebase' }
    rescue JSON::ParserError
      { success: false, error: 'Resposta inválida do Firebase' }
    rescue => e
      Rails.logger.error "Firebase signup error: #{e.message}"
      { success: false, error: 'Erro de conexão com Firebase' }
    end
  end
  
  def self.send_verification_email(id_token)
    api_key = ENV['FIREBASE_API_KEY']
    return false unless api_key.present? && id_token.present?
    
    begin
      uri = URI("#{FIREBASE_VERIFY_EMAIL_URL}?key=#{api_key}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.read_timeout = 10
      http.open_timeout = 5
      
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = {
        requestType: 'VERIFY_EMAIL',
        idToken: id_token
      }.to_json
      
      response = http.request(request)
      response.code == '200'
      
    rescue => e
      Rails.logger.error "Firebase verification email error: #{e.message}"
      false
    end
  end
  
  private
  
  def self.valid_email?(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
  end
  

end