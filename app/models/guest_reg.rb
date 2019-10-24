class GuestReg < ApplicationRecord

  validates :full_name, presence: true
  validates :organization, presence: true
  validates :email, presence: true
  validates :purpose, presence: true
  validates :escortant, presence: true
  
end
