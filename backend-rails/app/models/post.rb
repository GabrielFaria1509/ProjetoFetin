class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  validates :content, presence: true, length: { minimum: 1, maximum: 2000 }
  validates :user, presence: true
  
  scope :recent, -> { order(created_at: :desc) }
  
  def tags
    # Extrair hashtags do conteúdo
    content.scan(/#\w+/).map { |tag| tag[1..-1] }
  end
  
  def liked_by?(user)
    likes.exists?(user: user)
  end
end