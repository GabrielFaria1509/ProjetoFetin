class Forum < ApplicationRecord
  belongs_to :user
  has_many :user_posts, dependent: :destroy
end
