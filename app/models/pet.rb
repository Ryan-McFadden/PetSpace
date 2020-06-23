class Pet < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments

  scope :alpha, -> {order(:name)}
  scope :most_comments, -> {left_joins(:comments).group('pets.id').order('count(pets.id) desc')}
end
