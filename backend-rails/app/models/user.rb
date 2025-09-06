class User < ApplicationRecord
  has_secure_password
  
  before_validation :set_name_from_username, if: -> { name.blank? && username.present? }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, length: { minimum: 2, maximum: 50 }
  validates :password, presence: true, length: { minimum: 8, message: "deve ter pelo menos 8 caracteres" }, confirmation: true
  validates :user_type, inclusion: { in: %w[Responsável Professor] }, allow_nil: true
  
  has_many :user_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  before_save :downcase_email
  
  private
  
  def downcase_email
    self.email = email.downcase if email.present?
  end
  
  def set_name_from_username
    # Pega a primeira parte do username antes do primeiro número, espaço, ou qualquer outro separador que quiser
    self.name = username.split(/\W|[0-9]/).first.capitalize if username.present?
  end
end
