class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :pet

  validates :content, presence: true
end
