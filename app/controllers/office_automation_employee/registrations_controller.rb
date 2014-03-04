require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class RegistrationsController < DeviseInvitable::RegistrationsController
    def new
      @user = User.new
      @user.build_company
      render '/office_automation_employee/devise/registrations/new'
    end

    def create

      @user = User.new(user_params)
      puts "******"
      puts @user.company.inspect
      puts "*********"
      puts Role::ADMIN
      @user.role = [Role::ADMIN]

      if @user.valid? && @user.company.valid?
        @user.company.roles = Role.all
        @user.company.save
        @user.save
        flash[:success] = "Congratulations!! You have successfully created account. Confirmation mail  has been sent to your mail account."
        redirect_to office_automation_employee.new_user_registration_path
      else
        flash[:danger] = "Please fill the mandatory fields"
        render '/office_automation_employee/devise/registrations/new'
      end
    end

    private

    def user_params
      params[:user].permit(:email, :password, :password_confirmation, company_attributes: [:name, :registration_date, :company_url, :same_as_flag, registered_address: [:address, :pincode, :city, :state, :country, :phone], current_address: [:address, :pincode, :city, :state, :country, :phone]])
    end

  end
end
