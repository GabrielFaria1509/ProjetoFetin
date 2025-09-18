Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Permitir todas as origens temporariamente
    
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: false,
      max_age: 86400
  end
end