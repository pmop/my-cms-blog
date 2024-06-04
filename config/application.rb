require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BlogApp
  class BlogApp::Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
    config.action_view.form_with_generates_remote_forms = false
    # So Sprockets can see JS deps which are placed under node_modules
    config.autoload_lib(ignore: %w(assets tasks))
    config.assets.paths << Rails.root.join('node_modules')
    config.autoload_paths << "#{root}/lib/errors"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
