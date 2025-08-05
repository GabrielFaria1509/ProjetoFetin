class Content < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :category, presence: true
  validates :author, presence: true

  scope :published, -> { where('published_at <= ?', Time.current) }
  scope :by_category, ->(category) { where(category: category) }
end