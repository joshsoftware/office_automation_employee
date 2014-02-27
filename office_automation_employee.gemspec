$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "office_automation_employee/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "office_automation_employee"
  s.version     = OfficeAutomationEmployee::VERSION
  s.authors     = ["yogesh", "pranav", "shweta"]
  s.email       = ["officeautomation@joshsoftware.com"]
  s.homepage    = "https://github.com/joshsoftware/office_automation_employee"
  s.summary     = "An Mountable engine for Employee management"
  s.description = "An mountable Engine for Employee management tasks like updating and inviting new employees etc."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.3"
  s.add_dependency "devise"
  s.add_dependency "devise_invitable"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails", ">= 3.2"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "nested_form"
  s.add_dependency "simple_form"
  s.add_dependency "country_select"
  s.add_dependency "mongoid"
  s.add_dependency "mongoid_slug"
  s.add_dependency "cancan"
  s.add_dependency "haml-rails"
end
