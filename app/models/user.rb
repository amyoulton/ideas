class User < ApplicationRecord
    has_secure_password
    has_many :ideas
    has_many :reviews

    has_many :likes, dependent: :destroy
    has_many :liked_ideas, through: :likes, source: :idea

    validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
end
