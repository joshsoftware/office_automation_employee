module OfficeAutomationEmployee
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def mount_engine
      route "mount OfficeAutomationEmployee::Engine => '/office_automation_employee'"
    end

    def load_seed_data
      append_file 'db/seeds.rb', 'OfficeAutomationEmployee::Engine.load_seed'
      rake 'db:seed'
    end

    def copy_abilities
      copy_file 'ability.rb', 'app/models/ability.rb'
    end
  end
end
