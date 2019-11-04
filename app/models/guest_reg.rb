class GuestReg < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :full_name, presence: true
  validates :organization, presence: true
  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :alt_email, allow_blank: true, format: { with: EMAIL_REGEX }
  validates :purpose, presence: true
  validates :escortant, presence: true

  before_create do
    prefix = IwaoConfig.fetch(:radius_username_prefix)
    suffix = IwaoConfig.fetch(:radius_username_suffix)

    self.uuid = SecureRandom.uuid.tr('-', '')
    self.username = "#{prefix}#{Digest::SHA256.hexdigest(self.email)[0, 6]}#{suffix}"
    self.not_after = Date.today.end_of_day
  end

  after_commit on: :create do
    RegistrationNotifierMailer.registration_receipt(self).deliver
    RegistrationNotifierMailer.request_for_approval(self).deliver
  end

  def to_param
    uuid
  end

  def to_s
    s = ""

    self.attributes.each do |key, value|
      next if ["uuid", "username", "not_before", "approved", "approved_at", "updated_at"].include?(key)
      next if key == "alt_email" && value.empty?
      s << "#{I18n.t("activerecord.attributes.guest_reg.#{key}")}:\n\t#{value}\n"
    end
    s
  end

  def approved?
    self.approved
  end

  def approve
    raise StandardError if self.approved?

    self.approved = true
    self.approved_at = Time.zone.now
    create_radius_user
    self.save!

    RegistrationNotifierMailer.registration_approved(self).deliver

    self
  end

  def radius_password
    return unless self.approved?

    f = Fradium.new(Settings.radius.to_h)
    raduser = f.find_user(self.username)
    raduser.first[:value]
  end

  private

  def create_radius_user
    f = Fradium.new(Settings.radius.to_h)
    raduser = f.find_user(self.username)

    if raduser&.count == 0
      f.create_user(self.username)
    else
      f.modify_user(self.username)
    end

    f.set_expiration(self.username, self.not_after.to_time)
  end

end
