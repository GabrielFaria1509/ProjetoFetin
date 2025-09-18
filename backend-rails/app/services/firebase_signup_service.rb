require 'net/http'
require 'json'

class FirebaseSignupService
  FIREBASE_SIGNUP_URL = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp'
  FIREBASE_VERIFY_EMAIL_URL = 'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode'
  
  def self.create_user(email, password)
    api_key = ENV['FIREBASE_API_KEY']
    return { success: false, error: 'Firebase API key not configured' } unless api_key
    
    # Validações de segurança
    return { success: false, error: 'Email inválido' } unless valid_email?(email)
    return { success: false, error: 'Senha deve ter pelo menos 8 caracteres' } if password.length < 8
    return { success: false, error: 'Senha muito fraca' } unless strong_password?(password)
    
    uri = URI("#{FIREBASE_SIGNUP_URL}?key=#{api_key}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request.body = {
      email: email,
      password: password,
      returnSecureToken: true
    }.to_json
    
    begin
      response = http.request(request)
      data = JSON.parse(response.body)
      
      if response.code == '200'
        # Enviar email de verificação
        verification_result = send_verification_email(data['idToken'])
        
        {
          success: true,
          firebase_uid: data['localId'],
          email: data['email'],
          token: data['idToken'],
          email_sent: verification_result[:success]
        }
      else
        error_message = case data['error']['message']
                       when 'EMAIL_EXISTS'
                         'Este email já está em uso'
                       when 'WEAK_PASSWORD'
                         'Senha muito fraca'
                       when 'INVALID_EMAIL'
                         'Email inválido'
                       else
                         'Erro ao criar conta'
                       end
        
        { success: false, error: error_message }
      end
    rescue => e
      { success: false, error: 'Erro de conexão com Firebase' }
    end
  end
  
  def self.send_verification_email(id_token)
    api_key = ENV['FIREBASE_API_KEY']
    return { success: false } unless api_key
    
    uri = URI("#{FIREBASE_VERIFY_EMAIL_URL}?key=#{api_key}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request.body = {
      requestType: 'VERIFY_EMAIL',
      idToken: id_token
    }.to_json
    
    begin
      response = http.request(request)
      { success: response.code == '200' }
    rescue
      { success: false }
    end
  end
  
  private
  
  def self.valid_email?(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
  end
  
  def self.strong_password?(password)
    # Pelo menos 8 caracteres, 1 maiúscula, 1 minúscula, 1 número
    password.match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}\z/)
  end
end