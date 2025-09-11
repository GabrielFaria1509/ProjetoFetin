class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reactions, dependent: :destroy
  
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
  
  def reaction_by(user)
    reactions.find_by(user: user)&.reaction_type
  end
  
  def reaction_counts
    reactions.group(:reaction_type).count
  end
end