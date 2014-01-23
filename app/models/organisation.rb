class Organisation < ActiveRecord::Base

  has_many :users
  has_many :user_groups

  has_many :questions
  has_many :pages
  has_many :feedbacks
  has_many :ideas
  has_many :comments
end
