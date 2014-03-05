require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class ConfirmationsController < Devise::ConfirmationsController
    def new
      self.resource = resource_class.new
      render 'office_automation_employee/devise/confirmations/new'
    end

    def create
      self.resource = resource_class.send_confirmation_instructions(resource_params)
      if successfully_sent?(resource)
        redirect_to after_confirmation_path_for(resource_name, resource)
      else
        flash[:danger] = "Please fill the fields accordingly."
        render 'office_automation_employee/devise/confirmations/new'
      end
    end

    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      if resource.errors.empty?
        resource.update_attributes status: "Active"
        set_flash_message(:notice, :confirmed) if is_flashing_format?
        redirect_to office_automation_employee.new_user_session_path
      else
        render 'office_automation_employee/devise/confirmations/new'
      end
    end
  end
end
