require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class InvitationsController < Devise::InvitationsController

    before_filter :is_admin?, only: ['new', 'create']

    def new
      self.resource = resource_class.new
      flash.delete :notice
      render 'office_automation_employee/devise/invitations/new'
    end

    def create
      self.resource = resource_class.new
      @invalid_email = Array.new

      invite_params[:email].chomp.split(',').each do |email|
        user = resource_class.create email: email, role: [Role::EMPLOYEE], company: current_inviter.company
        if user.errors.messages[:email].nil?
          flash[:notice] = "Invitations sent successfully to valid email addresses."
          user.invite! current_inviter
        else
          @invalid_email.push user
        end
      end

      if @invalid_email.empty?
        flash[:success] = "Invitations sent successfully to all email addresses."
        redirect_to office_automation_employee.new_user_invitation_path
      else
        flash[:danger] = "Please fill the fields accordingly."
        render 'office_automation_employee/devise/invitations/new'
      end
    end

    def edit
      resource.invitation_token = params[:invitation_token]
      render 'office_automation_employee/devise/invitations/edit'
    end

    def update
      self.resource = accept_resource
      if resource.errors.empty?
        resource.status = "Active"
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message
        sign_in(resource_name, resource)
        redirect_to after_invite_path_for resource
      else
        render 'office_automation_employee/devise/invitations/edit'
      end
    end

    private

    def is_admin?
      current_user.role.include? :admin
    end
  end
end
