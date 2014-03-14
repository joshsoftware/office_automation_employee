require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class InvitationsController < Devise::InvitationsController

    def new
      @company = current_user.company
      authorize! :manage, @company
      @company.users.build

      render 'office_automation_employee/devise/invitations/new'
    end

    def create
      @company = current_user.company
      @users_attributes = params[:company][:users_attributes]
      @csv_file = params[:company][:csv_file]
      @invalid_rows, invalid_email, total_rows = Array.new, 0, 0
      authorize! :manage, @company

      if @csv_file.nil?
        invalid_email = current_user.invite_by_fields @users_attributes
      else
        raise CSV::MalformedCSVError unless @csv_file.content_type.eql? "text/csv"
        @invalid_rows, total_rows = current_user.invite_by_csv @csv_file
        # if email fields are given along with csv file
        invalid_email = current_user.invite_by_fields @users_attributes if @users_attributes.first.last[:email].present?
      end

      if invalid_email.zero? and @invalid_rows.empty?
        flash[:notice] = "Invitation sent successfully..."
        redirect_to office_automation_employee.company_users_path(@company)
      else
        total_sent = (@users_attributes.count - invalid_email) + (total_rows - @invalid_rows.count)
        total_failed = invalid_email + @invalid_rows.count
        flash[:notice] = "# Invitation sent : #{total_sent} and Failed : #{total_failed}"
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

    rescue_from CSV::MalformedCSVError do |exception|
      flash[:danger] = "Invalid CSV file."
      redirect_to office_automation_employee.new_user_invitation_path
    end
  end
end
