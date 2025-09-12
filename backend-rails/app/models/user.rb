class User < ApplicationRecord
  has_secure_password
  
  before_validation :set_name_from_username, if: -> { name.blank? && username.present? }

  validates :email, presence: { message: "é obrigatório" }, 
                    uniqueness: { case_sensitive: false, message: "Este e-mail já foi cadastrado!" }, 
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "formato inválido" }
  validates :username, presence: { message: "é obrigatório" }, 
                       uniqueness: { case_sensitive: false, message: "Este username já foi cadastrado!" },
                       length: { minimum: 2, maximum: 30, too_short: "deve ter pelo menos 2 caracteres", too_long: "deve ter no máximo 30 caracteres" },
                       format: { with: /\A[a-z0-9_]+\z/, message: "pode conter apenas letras, números e underscore" }
  validates :password, presence: { message: "é obrigatória" }, on: :create
  validates :password, length: { minimum: 8, message: "deve ter pelo menos 8 caracteres" }, allow_blank: true
  validates :password, confirmation: { message: "não confere com a confirmação" }, allow_blank: true
  validates :user_type, inclusion: { in: %w[Responsável Profissional] }, allow_nil: true
  validates :account_type, inclusion: { in: %w[normal verified bot] }
  
  has_many :posts, dependent: :destroy
  has_many :user_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reactions, dependent: :destroy
  
  before_save :downcase_email
  before_save :downcase_username
  
  private
  
  def downcase_email
    self.email = email.downcase if email.present?
  end
  
  def downcase_username
    if username.present?
      # Normalização completa: minúsculo, remove espaços, caracteres especiais
      self.username = username.downcase.strip.gsub(/[^a-z0-9_]/, '')
    end
  end
  
  def set_name_from_username
    # Pega a primeira parte do username antes do primeiro número, espaço, ou qualquer outro separador que quiser
    self.name = username.split(/\W|[0-9]/).first.capitalize if username.present?
  end
end
