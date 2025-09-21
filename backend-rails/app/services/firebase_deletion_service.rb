class FirebaseDeletionService
  require 'net/http'
  require 'json'
  
  def self.delete_user(firebase_uid)
    api_key = ENV['FIREBASE_API_KEY']
    return false unless api_key.present? && firebase_uid.present?
    
    begin
      # Deletar usuário do Firebase Auth
      uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:delete?key=#{api_key}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.read_timeout = 10
      http.open_timeout = 5
      
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = {
        localId: firebase_uid
      }.to_json
      
      response = http.request(request)
      
      if response.code == '200'
        Rails.logger.info "Firebase user deleted successfully: #{firebase_uid}"
        true
      else
        Rails.logger.error "Firebase deletion failed: #{response.body}"
        false
      end
      
    rescue => e
      Rails.logger.error "Firebase deletion error: #{e.message}"
      false
    end
  end
end