class Team < ApplicationRecord
  belongs_to :company
  has_many :shifts
  has_many :jobs
end
