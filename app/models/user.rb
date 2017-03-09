class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  has_many :directoies
  has_many :workers
  has_many :admins

  has_many :working_teams, through: :workers, source: :team
  has_many :admin_companies, through: :admins, source: :company

  def email_required?
    false
  end

  def password_required?
    false
  end
end
