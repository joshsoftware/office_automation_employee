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
        flash[:success] = "Congratulations!! You have successfully created an account. Confirmation mail  has been sent to your mail account."
        redirect_to office_automation_employee.new_user_registration_path
      else
        @registered_address = @company.registered_address
        @current_address = @company.current_address
        flash[:danger] = "Please fill the mandatory fields"
        render '/office_automation_employee/devise/registrations/new'
      end
    end

    def update
      authorize! :edit, @user
      if update_resource(@user, user_password_params)
        flash[:success] = "Password Updated Successfully."
        sign_in @user, bypass: true
        redirect_to office_automation_employee.edit_company_user_path(@user.company, @user)
      else
        flash[:danger] = "Please fill the fields accordingly."
        clean_up_passwords @user
        render 'office_automation_employee/users/edit'
      end
    end

    private


    def company_params
      params[:company].permit(:name, :registration_date, :company_url, :logo, :same_as_registered_address, registered_address: [:address, :pincode, :city, :state, :country, :phone], current_address: [:address, :pincode, :city, :state, :country, :phone] , users_attributes: [:email, :password, :password_confirmation])
    end

    def user_password_params
      params[:user].permit(:password, :password_confirmation, :current_password)
    end
  end
end
