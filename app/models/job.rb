class Job < ActiveRecord::Base
  belongs_to :team
  has_many :shifts, dependent: :destroy
end
