class User < ApplicationRecord
    has_secure_password
    has_many :ideas
    has_many :reviews

    validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
end
