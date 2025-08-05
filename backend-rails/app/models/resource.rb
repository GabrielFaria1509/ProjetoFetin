class Resource < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :resource_type, presence: true

  enum resource_type: { pdf: 0, article: 1, guide: 2, checklist: 3 }
end