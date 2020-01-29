class RegistrationNotifierMailer < ApplicationMailer
  default from: IwaoConfig.fetch(:email_sender)

  def registration_receipt(guest_reg)
    @guest_reg = guest_reg
    header = {}
    header.store(:to, guest_reg.email)
    header.store(:cc, guest_reg.alt_email) unless guest_reg.alt_email.blank?
    header.store(:subject, IwaoConfig.fetch(:email_subject_registration_receipt))
    mail(header)
  end

  def request_for_approval(guest_reg)
    @guest_reg = guest_reg
    header = {
      to: IwaoConfig.fetch(:administrator_email),
      subject: IwaoConfig.fetch(:email_subject_request_for_approval)
    }
    mail(header)
  end

  def registration_approved(guest_reg)
    @guest_reg = guest_reg
    header = {}
    header.store(:to, guest_reg.email)
    header.store(:cc, guest_reg.alt_email) unless guest_reg.alt_email.blank?
    header.store(:subject, IwaoConfig.fetch(:email_subject_registration_approved))
    mail(header)
  end
end
