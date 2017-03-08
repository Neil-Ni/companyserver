class Company < ApplicationRecord
  belongs_to :company
  has_one :user
end
