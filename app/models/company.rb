class Company < ApplicationRecord
  has_many :users
  has_many :teams
  has_many :directories
  has_many :admins
end
