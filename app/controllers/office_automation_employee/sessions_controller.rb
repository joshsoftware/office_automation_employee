require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class SessionsController < Devise::SessionsController
    def new
      self.resource = resource_class.new(sign_in_params)
      render '/office_automation_employee/devise/sessions/new'
    end

    protected

    def after_sign_out_path_for(resource)
      office_automation_employee.new_user_session_path
    end
  end
end
