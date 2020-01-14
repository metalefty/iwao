class GuestRegNotifier
  include Rails.application.routes.url_helpers

  class SlackNotificationNotEnabled < StandardError; end

  def initialize(guest_reg)
    @guest_reg = guest_reg

    @slack_notification_enable = IwaoConfig.fetch(:slack_notification_enable)
    @slack = Slack::Notifier.new(Rails.application.credentials.dig(:slack, :webhook_url))

    Rails.application.routes.default_url_options =
      Rails.application.config.action_mailer.default_url_options
  end

  def email_request_for_approval
    RegistrationNotifierMailer.request_for_approval(@guest_reg).deliver
  end

  def email_registration_receipt
    RegistrationNotifierMailer.registration_receipt(@guest_reg).deliver
  end

  def email_registration_approved
    raise GuestReg::RegistrationNotApprovedError unless @guest_reg.approved?
    RegistrationNotifierMailer.registration_approved(@guest_reg).deliver
  end

  def slack_request_for_approval
    return if Rails.env.test?
    raise SlackNotificationNotEnabled unless @slack_notification_enable

    @slack.post text: '<!here>', attachments: slack_attachment_request_for_approval
  end

  def slack_approved
    return if Rails.env.test?
    raise SlackNotificationNotEnabled unless @slack_notification_enable

    @slack.post text: "#{I18n.t('notification.guest_reg.request_has_been_approved', id: @guest_reg.id)}"
  end

  private

  def slack_attachment_request_for_approval
    subject = IwaoConfig.fetch(:email_subject_request_for_approval)
    {
      fallback: subject,
      pretext: "#{I18n.t('notification.guest_reg.request_for_approval')}\n#{guest_reg_url(@guest_reg)}",
      color: :good,
      fields: assemble_slack_attachment_fields
    }
  end

  def assemble_slack_attachment_fields
    fields = []

    @guest_reg.attributes.each do |key, value|
      next if GuestReg::EXCLUDE_ATTRIBUTES.include?(key)
      next if key == "alt_email" && value.empty?

      fields << {
        title: I18n.t("activerecord.attributes.guest_reg.#{key}"),
        value: value&.to_s
      }
    end

    fields
  end
end
