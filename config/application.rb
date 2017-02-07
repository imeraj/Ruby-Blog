require_relative 'boot'
require_relative '../lib/delta_formatter'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # register our middleware
    config.middleware.use('DeltaLogger', '*')
    config.log_formatter = DeltaFormatter.new
  end
end
