class GuestReg < ApplicationRecord

  validates :full_name, presence: true
  validates :organization, presence: true
  validates :email, presence: true
  validates :purpose, presence: true
  validates :escortant, presence: true

  before_create do
    self.uuid = SecureRandom.uuid.tr('-', '')
  end

  def to_param
    uuid
  end
end
