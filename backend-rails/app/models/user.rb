class User < ApplicationRecord
  has_secure_password
  
  before_validation :set_name_from_username, if: -> { name.blank? && username.present? }

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :user_type, inclusion: { in: %w[Responsável Professor] }
  
  private
  def set_name_from_username
    # Pega a primeira parte do username antes do primeiro número, espaço, ou qualquer outro separador que quiser
    self.name = username.split(/\W|[0-9]/).first.capitalize
  end
end
