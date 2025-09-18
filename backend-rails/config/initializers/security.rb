# Configurações de segurança para produção
Rails.application.configure do
  # Forçar HTTPS em produção
  if Rails.env.production?
    config.force_ssl = true
    config.ssl_options = {
      redirect: { status: 301, body: [] },
      secure_cookies: true,
      hsts: {
        expires: 1.year,
        subdomains: true,
        preload: true
      }
    }
  end
  
  # Headers de segurança
  config.force_ssl = Rails.env.production?
  
  # Configurar Content Security Policy
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https
    policy.style_src   :self, :https, :unsafe_inline
    policy.connect_src :self, :https
    policy.frame_ancestors :none
  end
  
  # Nonce para CSP
  config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }
  config.content_security_policy_nonce_directives = %w(script-src style-src)
  
  # Headers de segurança adicionais
  config.force_ssl = Rails.env.production?
end

# Configurações de sessão segura
Rails.application.config.session_store :cookie_store,
  key: '_tism_session',
  secure: Rails.env.production?,
  httponly: true,
  same_site: :strict