require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class RegistrationsController < DeviseInvitable::RegistrationsController
    def new
      self.resource = resource_class.new
      @company = resource.build_company
      @registered_address = @company.build_registered_address
      @current_address = @company.build_current_address
      render '/office_automation_employee/devise/registrations/new'
    end

    def create

      self.resource = resource_class.new(user_params)
      resource.roles = [Role::ADMIN]

      if resource.valid? && resource.company.valid?
        resource.company.roles = Role.all
        resource.save
        flash[:success] = "Congratulations!! You have successfully created account. Confirmation mail  has been sent to your mail account."
        redirect_to office_automation_employee.new_user_registration_path
      else
        @company = resource.company
        @registered_address = @company.registered_address
        @current_address = @company.current_address
        flash[:danger] = "Please fill the mandatory fields"
        render '/office_automation_employee/devise/registrations/new'
      end
    end

    private

    def user_params
      params[:user].permit(:email, :password, :password_confirmation, company_attributes: [:name, :registration_date, :company_url, :same_as_registered_address, registered_address: [:address, :pincode, :city, :state, :country, :phone], current_address: [:address, :pincode, :city, :state, :country, :phone]])
    end
  end
end
