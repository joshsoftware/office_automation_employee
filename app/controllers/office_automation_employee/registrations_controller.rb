require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class RegistrationsController < DeviseInvitable::RegistrationsController
    def new
      @user = User.new
      @company = @user.build_company
      @registered_address = @company.build_registered_address
      @current_address = @company.build_current_address
      render '/office_automation_employee/devise/registrations/new'
    end

    def create

      @user = User.new(user_params)
      puts Role::ADMIN
      @user.role = [Role::ADMIN]

      if @user.valid? && @user.company.valid?
        @user.company.roles = Role.all
        @user.save
        flash[:success] = "Congratulations!! You have successfully created account. Confirmation mail  has been sent to your mail account."
        redirect_to office_automation_employee.new_user_registration_path
      else
        @company = @user.company
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
