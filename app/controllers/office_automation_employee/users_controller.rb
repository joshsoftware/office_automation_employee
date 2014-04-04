require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class UsersController < ApplicationController
    load_and_authorize_resource

    def edit
      @profile = @user.build_profile unless @user.profile?
      @personal_profile = @user.build_personal_profile unless @user.personal_profile?
      @current_address = @user.personal_profile ? @user.personal_profile.current_address : @user.personal_profile.build_current_address
      @permanent_address = @user.personal_profile ? @user.personal_profile.permanent_address : @user.personal_profile.build_permanent_address
      @attachments = @user.attachments.build     
    end

    def update
      if @user.update_attributes user_params
        if params[:user].include?(:personal_profile_attributes)
          @permanent_address = @user.personal_profile.permanent_address
          @current_address = @user.personal_profile.current_address
        end
        flash[:success] = 'Profile updated Succesfully'
        if params[:user].include?(:attachments_attributes)

          @attachments_to_display = [] 
          uploaded_length = params[:user][:attachments_attributes].length 
          if uploaded_length
            attachments = @user.attachments.desc(:created_at)

            uploaded_length.times do |i|
              @attachments_to_display << attachments[i]
              @attachments_to_display = @attachments_to_display.reverse
            end
            @attachments = @user.attachments.build 
          end


        end
        respond_to do |format|
          format.js
        end
      else
        @user.build_personal_profile unless @user.personal_profile?
        @user.build_profile unless @user.profile?
        @permanent_address = @user.personal_profile.permanent_address
        @current_address = @user.personal_profile.current_address
        flash[:danger] = 'Please fill the fields accordingly.'
        respond_to do |format|
          format.js 
        end
      end
    end

    def index
      @company = Company.find params[:company_id]
      @users = @company.users.full_text_search(params[:q])
      @failure_message = 'No Result Found' if @users.count == 0
      @users = @users.page(params[:page]) 
    end

    def destroy
      if @user.destroy
        redirect_to office_automation_employee.company_users_path(@user.company)
      else
        flash[:danger] = 'Some error occured while removing user'
        render :show
      end
    end

    def resend_invitation
      if @user.invite!(current_user)
        flash[:notice] = "Invitation sent successfully..."
        redirect_to office_automation_employee.company_user_path(@user.company, @user)
      else
        flash[:danger] = 'Some error occured while sending invitation'
        render :show
      end
    end

    def activation_status
      if (@user.status.eql?("Active") ? @user.update_attribute(:status, "Deactive") : @user.update_attribute(:status, "Active"))
        redirect_to office_automation_employee.company_user_path(@user.company, @user)
      else
        flash[:danger] = 'Some error occured while changing status'
        render :show
      end
    end


    private
    def user_params
      params[:user][:attachments_attributes].keep_if{|k,v| v[:_destroy] == 'false' if v.has_key?(:_destroy) } if params[:user].include?(:attachments_attributes)

      params[:user].permit(:image, profile_attributes: [:first_name, :middle_name, :last_name, :gender, :blood_group, :date_of_birth, :skills, :mobile_number, :designation], personal_profile_attributes: [:pan_number, :personal_email, :passport_number, :qualification, :date_of_joining, :previous_company ,:work_experience, :same_as_permanent_address, permanent_address: [:address, :city, :pincode, :state, :country, :phone], current_address: [:address, :city, :pincode, :state, :country, :phone]], attachments_attributes: [:name, :document, :_destroy])

    end

  end
end
