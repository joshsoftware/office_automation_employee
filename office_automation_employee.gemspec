$:.push File.expand_path("../lib", __FILE__)

require "office_automation_employee/version"

Gem::Specification.new do |s|
  s.name        = "office_automation_employee"
  s.version     = OfficeAutomationEmployee::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["yogesh", "shweta"]
  s.email       = ["joshofficeautomation@gmail.com"]
  s.homepage    = "https://github.com/joshsoftware/office_automation_employee"
  s.summary     = "A Mountable engine for Employee management"
  s.description = "A Mountable Engine for Employee management tasks like creating company, adding multiple roles, inviting new employees, monitoring status of invitations etc."

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.3"
  s.add_dependency "mongoid"
  s.add_dependency "mongoid_slug"
  s.add_dependency "mongoid_search"
  s.add_dependency "devise"
  s.add_dependency "devise_invitable"
  s.add_dependency "devise-async"
  s.add_dependency "sidekiq"
  s.add_dependency "kaminari"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails", ">= 3.2"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "bootstrap-datepicker-rails"
  s.add_dependency "colorbox-rails"
  s.add_dependency "nested_form"
  s.add_dependency "simple_form"
  s.add_dependency "country_select"
  s.add_dependency "cancan"
  s.add_dependency "haml-rails"
  s.add_dependency "carrierwave-mongoid"
  s.add_dependency "rmagick"
  s.add_dependency "coffee-rails"
  s.add_dependency "remotipart", '~> 1.2'
end
