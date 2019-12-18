creds = Aws::Credentials.new(
  Rails.application.credentials.dig(:aws, :access_key_id),
  Rails.application.credentials.dig(:aws, :secret_access_key)
)
Aws::Rails.add_action_mailer_delivery_method(:ses, credentials: creds, region: 'us-west-2')
