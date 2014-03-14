require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class UsersController < ApplicationController

    def edit
      @user = current_user
      @profile = @user.build_profile unless @user.profile?
      @personal_profile = @user.build_personal_profile unless @user.personal_profile?
      @current_address = @user.personal_profile.build_current_address unless @user.personal_profile.current_address?
      @permanent_address= @user.personal_profile.build_permanent_address unless @user.personal_profile.permanent_address?
      @current_address = @user.personal_profile.current_address
      @permanent_address = @user.personal_profile.permanent_address
    end

    def update

      @user = current_user
      
      if @user.update_attributes user_params
        flash[:success] = 'Profile updated Succesfully'
        redirect_to office_automation_employee.edit_company_user_path(current_user.company, current_user)
      else
        @user.build_personal_profile unless @user.personal_profile?
        @user.build_profile unless @user.profile?
        @permanent_address = @user.personal_profile.permanent_address
        @current_address = @user.personal_profile.current_address
        flash[:danger] = 'Unable to update profile'
        render :edit
      end

    end

    def user_params
      params[:user].permit(:image, profile_attributes: [:first_name, :middle_name, :last_name, :gender, :blood_group, :date_of_birth, :skills, :mobile_number], personal_profile_attributes: [:pan_number, :personal_email, :passport_number, :qualification, :date_of_joining, :previous_company ,:same_as_permanent_address, permanent_address: [:address, :city, :pincode, :state, :country, :phone], current_address: [:address, :city, :pincode, :state, :country, :phone]])
    end
  end
end
