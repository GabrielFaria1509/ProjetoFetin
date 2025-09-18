Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.env.production? ? [
      'https://tism-app.com',
      'https://www.tism-app.com',
      /\Ahttps:\/\/.*\.tism-app\.com\z/
    ] : '*'
    
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: false,
      max_age: 86400
  end
end