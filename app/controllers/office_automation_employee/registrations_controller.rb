require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class RegistrationsController < DeviseInvitable::RegistrationsController
    def new
      build_resource
      render '/office_automation_employee/devise/registrations/new'
    end

    def create
      @user = User.new(params[:user].permit(:email, :password, :password_confirmation))
      @user.update_attributes role: ['admin']
      if @user.save
        flash[:success] = "Congratulations!! You have successfully created an account. Confirmation mail  has been sent to your mail account."
        redirect_to office_automation_employee.new_user_registration_path
      else
        flash[:danger] = "Please fill the fields accordingly."
        render '/office_automation_employee/devise/registrations/new'
      end
    end
  end
end
