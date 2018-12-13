require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module TaskApp
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators do |g|
      g.routes false
      g.assets false
      g.helper false
      g.jbuilder false
      g.template_engine :erb
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.ficture_replacement :facrtory_bot, dir: "spec/factories"
    end
    config.generators.system_tests = nil
  end
end
