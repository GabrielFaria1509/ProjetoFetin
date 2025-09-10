class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { minimum: 1, maximum: 2000 }
  validates :user, presence: true
  
  scope :recent, -> { order(created_at: :desc) }
  
  def tags
    # Extrair hashtags do conteúdo
    content.scan(/#\w+/).map { |tag| tag[1..-1] }
  end
end