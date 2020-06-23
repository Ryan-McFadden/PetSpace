class User < ApplicationRecord
    has_many :pets
    has_many :comments
    has_many :commented_pets, through: :comments, source: :pet

    has_secure_password
end
