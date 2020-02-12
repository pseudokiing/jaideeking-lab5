class User < ApplicationRecord
  has_many :articles
  has_many :comments
  validates :name, presence: true
  validates :email, presence: true
end
