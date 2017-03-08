class Team < ApplicationRecord
  belongs_to :company
  has_many :shifts
  has_many :jobs
  has_many :workers
  has_many :users, through: :workers
end
