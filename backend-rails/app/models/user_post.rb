class UserPost < ApplicationRecord
  belongs_to :user
  belongs_to :forum
  has_many :comments, dependent: :destroy
  
  validates :content, presence: { message: 'é obrigatório' }, length: { minimum: 1, maximum: 1000 }
  validates :title, presence: { message: 'é obrigatório' }
end
