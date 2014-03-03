require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class PasswordsController < Devise::PasswordsController
    def new
      self.resource = resource_class.new
      render 'office_automation_employee/devise/passwords/new'
    end

    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      if successfully_sent?(resource)
        redirect_to after_sending_reset_password_instructions_path_for(resource_name)
      else
        flash[:danger] = 'Please fill the fields accordingly.'
        render 'office_automation_employee/devise/passwords/new'
      end
    end

    def edit
      self.resource = resource_class.new
      resource.reset_password_token = params[:reset_password_token]
      render 'office_automation_employee/devise/passwords/edit'
    end

    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      if resource.errors.empty?
        resource.unlock_access! if unlockable?(resource)
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message(:notice, flash_message) if is_flashing_format?
        sign_in(resource_name, resource)
        redirect_to after_resetting_password_path_for(resource)
      else
        render 'office_automation_employee/devise/passwords/edit'
      end
    end
  end
end
