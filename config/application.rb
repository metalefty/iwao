require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Iwao
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    # SET THIS
    config.hosts << "iwao.example.com"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Restrict access on /admin
    config.middleware.use Rack::Access, {
      '/admin' => ENV['IWAO_ADMIN_ACCESS_ALLOWED_IP']&.split
    }
  end
end
