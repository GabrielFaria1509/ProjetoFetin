Rails.application.configure do
  config.secret_key_base = ENV['SECRET_KEY_BASE'] || 'd82246942e126b816937789b128f5ce5'
end