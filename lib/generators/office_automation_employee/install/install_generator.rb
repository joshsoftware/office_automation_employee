module OfficeAutomationEmployee
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_abilities
      copy_file 'ability.rb', 'app/models/ability.rb'
    end

    def mount_engine
      route "mount OfficeAutomationEmployee::Engine => '/office_automation_employee'"
    end
  end
end
