require 'devise'
require 'devise_invitable'
require 'devise-async'
require 'sidekiq'
require 'kaminari'
require 'mongoid'
require 'mongoid_search'
require 'mongoid_slug'
require 'carrierwave/mongoid'
require 'cancan'
require 'haml-rails'
require 'simple_form'
require 'nested_form'
require 'bootstrap-sass'
require 'bootstrap-datepicker-rails'
require 'colorbox-rails'
require 'country_select'

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
