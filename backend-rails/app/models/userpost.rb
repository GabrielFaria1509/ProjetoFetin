class UserPost < ApplicationRecord
  belongs_to :user
  belongs_to :forum
end
