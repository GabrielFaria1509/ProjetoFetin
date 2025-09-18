require 'net/http'
require 'json'

class FirebaseAuthService
  FIREBASE_AUTH_URL = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword'
  
  def self.authenticate_user(email, password)
    api_key = ENV['FIREBASE_API_KEY']
    return { success: false, error: 'Firebase API key not configured' } unless api_key
    
    uri = URI("#{FIREBASE_AUTH_URL}?key=#{api_key}")
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
        {
          success: true,
          firebase_uid: data['localId'],
          email: data['email'],
          token: data['idToken']
        }
      else
        error_message = case data['error']['message']
                       when 'EMAIL_NOT_FOUND', 'INVALID_PASSWORD'
                         'Email ou senha inválidos'
                       when 'USER_DISABLED'
                         'Usuário desabilitado'
                       when 'TOO_MANY_ATTEMPTS_TRY_LATER'
                         'Muitas tentativas. Tente novamente mais tarde'
                       else
                         'Erro na autenticação'
                       end
        
        { success: false, error: error_message }
      end
    rescue => e
      { success: false, error: 'Erro de conexão com Firebase' }
    end
  end
end