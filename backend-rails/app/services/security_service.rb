class SecurityService
  # Rate limiting por IP
  RATE_LIMITS = {
    login: { max: 5, window: 15.minutes },
    signup: { max: 3, window: 1.hour },
    general: { max: 100, window: 1.hour }
  }.freeze
  
  def self.rate_limit_exceeded?(ip, action = :general)
    cache_key = "rate_limit:#{action}:#{ip}"
    current_count = Rails.cache.read(cache_key) || 0
    limit = RATE_LIMITS[action]
    
    if current_count >= limit[:max]
      true
    else
      Rails.cache.write(cache_key, current_count + 1, expires_in: limit[:window])
      false
    end
  end
  
  def self.suspicious_email?(email)
    # Lista de domínios suspeitos
    suspicious_domains = %w[
      10minutemail.com
      guerrillamail.com
      mailinator.com
      tempmail.org
      throwaway.email
    ]
    
    domain = email.split('@').last&.downcase
    suspicious_domains.include?(domain)
  end
  
  def self.validate_user_data(params)
    errors = []
    
    # Validar nome
    if params[:name].present?
      errors << 'Nome muito curto' if params[:name].length < 2
      errors << 'Nome muito longo' if params[:name].length > 50
      errors << 'Nome contém caracteres inválidos' unless params[:name].match?(/\A[a-zA-ZÀ-ÿ\s]+\z/)
    end
    
    # Validar username
    if params[:username].present?
      errors << 'Username muito curto' if params[:username].length < 3
      errors << 'Username muito longo' if params[:username].length > 20
      errors << 'Username inválido' unless params[:username].match?(/\A[a-z0-9_]+\z/)
      errors << 'Username não pode ser apenas números' if params[:username].match?(/\A\d+\z/)
    end
    
    # Validar email
    if params[:email].present?
      errors << 'Email suspeito detectado' if suspicious_email?(params[:email])
    end
    
    errors
  end
  
  def self.sanitize_input(text)
    return nil unless text.present?
    
    # Remove caracteres perigosos
    text.gsub(/[<>\"'&]/, '')
        .strip
        .squeeze(' ')
  end
end