# OfficeAutomationEmployee

OfficeAutomationEmployee is a Rails engine for Employee management.

To install it, add this to your Gemfile and run bundle command

```ruby
gem 'office_automation_employee'
```


## Installation

Run the following generator to create initial configuration for OfficeAutomationEmployee.

    rails generate office_automation_employee:install

It will mount an engine in your application, load initial seed data (mongoid.yml should be present before running this generator) and also, it will create ability.rb (app/models/ability.rb).
