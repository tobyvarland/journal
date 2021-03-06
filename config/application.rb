require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Journal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Load STI models.
    config.autoload_paths += %W(#{Rails.root}/app/models/descriptor)

    # Set default time zone.
    config.time_zone = 'Eastern Time (US & Canada)'

    # Load custom config for HTTP authentication.
    config.journal_auth = config_for(:journal_auth)

  end
end
