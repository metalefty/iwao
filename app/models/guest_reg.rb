class GuestReg < ApplicationRecord

  validates :full_name, presence: true
  validates :organization, presence: true
  validates :email, presence: true
  validates :purpose, presence: true
  validates :escortant, presence: true

  before_create do
    prefix = IwaoConfig.fetch(:radius_username_prefix)
    suffix = IwaoConfig.fetch(:radius_username_suffix)

    self.uuid = SecureRandom.uuid.tr('-', '')
    self.username = "#{prefix}#{Digest::SHA256.hexdigest(self.email)[0, 6]}#{suffix}"
    self.not_after = Date.today.end_of_day
  end

  def to_param
    uuid
  end

  def approved?
    self.approved
  end

  def approve
    return self if self.approved?

    self.approved = true
    self.approved_at = Time.zone.now
    create_radius_user
    self.save!

    self
  end

  private

  def create_radius_user
    f = Fradium.new(Settings.radius.to_h)
    raduser = f.find_user(self.username)

    if raduser&.count == 0
      f.create_user(self.username)
    else
      f.modify_user(self.username)
      f.set_expiration(self.username, self.not_after.to_time)
    end
  end

end
