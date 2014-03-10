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

      @user.role = [Role::ADMIN]
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

    def edit
      resource = resource_class.find(current_user)
      @profile = resource.build_profile unless resource.profile?
      @personal_profile = resource.build_personal_profile unless resource.personal_profile?
      render '/office_automation_employee/devise/registrations/edit'
    end

    def update
      if current_user.update_attributes(update_user_params)
        flash[:success] = 'Profile updated Succesfully'
        redirect_to office_automation_employee.edit_user_registration_path
      else

        render '/office_automation_employee/devise/registrations/edit'
        flash[:danger] = 'Unable to update profile'
      end

    end
    private


    def company_params
      params[:company].permit(:name, :registration_date, :company_url, :same_as_registered_address, registered_address: [:address, :pincode, :city, :state, :country, :phone], current_address: [:address, :pincode, :city, :state, :country, :phone] , users_attributes: [:email, :password, :password_confirmation])
    end

    def update_user_params
      type = params.require(:user).permit(:update_type)
      case type[:update_type]
      when 'profile'
        params[:user].permit(profile_attributes: [:first_name, :middle_name, :last_name, :gender, :blood_group, :date_of_birth, :skills, :image, :mobile_number])

      when 'personal_profile'  
        params[:user].permit(personal_profile_attributes: [:pan_number, :personal_email, :passport_number, :qualification, :date_of_joining, :previous_company] ,permanant_address: [:address, :city, :pincode, :state, :country, :phone], current_address: [:address, :city, :pincode, :state, :country, :phone])
      end
    end
  end
end
