# Rate limiting para prevenir ataques
Rails.application.config.middleware.use Rack::Attack

# Configurações do Rack::Attack
Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

# Rate limit para login (5 tentativas por minuto por IP)
Rack::Attack.throttle('login/ip', limit: 5, period: 1.minute) do |req|
  req.ip if req.path == '/login' && req.post?
end

# Rate limit para cadastro (3 cadastros por hora por IP)
Rack::Attack.throttle('signup/ip', limit: 3, period: 1.hour) do |req|
  req.ip if req.path == '/signup' && req.post?
end

# Rate limit geral para API (100 requests por minuto por IP)
Rack::Attack.throttle('api/ip', limit: 100, period: 1.minute) do |req|
  req.ip
end

# Bloquear IPs suspeitos
Rack::Attack.blocklist('block suspicious IPs') do |req|
  # Adicionar IPs maliciosos conhecidos aqui se necessário
  false
end

# Resposta customizada para rate limit
Rack::Attack.throttled_response = lambda do |env|
  [
    429,
    { 'Content-Type' => 'application/json' },
    [{ error: 'Muitas tentativas. Tente novamente em alguns minutos.' }.to_json]
  ]
end