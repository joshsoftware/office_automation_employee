module OfficeAutomationEmployee
  class Engine < ::Rails::Engine
    isolate_namespace OfficeAutomationEmployee

    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

  end
end
