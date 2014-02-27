require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class SessionsController < Devise::SessionsController
    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      render '/office_automation_employee/devise/sessions/new'
    end

    def create
      self.resource = warden.authenticate!(auth_options)
      sign_in resource_name, resource
      respond_with resource, location: after_sign_in_path_for("/office_automation_employee")
    end
  end
end
