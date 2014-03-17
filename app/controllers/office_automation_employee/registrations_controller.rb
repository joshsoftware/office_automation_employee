require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class RegistrationsController < DeviseInvitable::RegistrationsController
    def new
      @company = Company.new
      @user = @company.users.build
      @registered_address = @company.build_registered_address
      @current_address = @company.build_current_address
      render '/office_automation_employee/devise/registrations/new'
    end

    def create
      #skip user creation 
      @company = Company.new(company_params.except('users_attributes'))

      #create user using users_attributes
      @user = @company.users.build(company_params['users_attributes'].first.last)

      @user.roles = [Role::ADMIN]
      @company.roles = Role.all
      if @company.save and @user.save
        flash[:success] = "Congratulations!! You have successfully created account. Confirmation mail  has been sent to your mail account."
        redirect_to office_automation_employee.new_user_registration_path
      else
        @registered_address = @company.registered_address
        @current_address = @company.current_address
        flash[:danger] = "Please fill the mandatory fields"
        render '/office_automation_employee/devise/registrations/new'
      end
    end


    private


    def company_params
      params[:company].permit(:name, :registration_date, :company_url, :same_as_registered_address, registered_address: [:address, :pincode, :city, :state, :country, :phone], current_address: [:address, :pincode, :city, :state, :country, :phone] , users_attributes: [:email, :password, :password_confirmation])
    end
  end
end
