require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class InvitationsController < Devise::InvitationsController
    before_filter :allow_access, only: ['new', 'create']

    def new
      @company = current_user.company
      @company.users.build

      render 'office_automation_employee/devise/invitations/new'
    end

    def create
      @company = current_user.company
      @users_attributes = params[:company][:users_attributes]
      @csv_file = params[:company][:csv_file]
      invalid_email_fields, total_email_fields, total_csv_rows = 0, 0, 0

      if @csv_file.nil?
        invalid_email_fields, total_email_fields = current_user.invite_by_fields @users_attributes
      else
        raise CSV::MalformedCSVError unless @csv_file.content_type.eql? "text/csv"
        total_csv_rows = current_user.invite_by_csv @csv_file

        # if email fields are given along with csv file
        invalid_email_fields, total_email_fields = current_user.invite_by_fields @users_attributes if @users_attributes.first.last[:email].present?
      end

      if invalid_email_fields.zero? and (@csv_file.nil? or current_user.invalid_csv_data.empty?)
        flash[:notice] = "Invitation sent successfully..."
        redirect_to office_automation_employee.company_users_path(@company)
      else
        total_sent = (total_email_fields - invalid_email_fields) + ((total_csv_rows - current_user.invalid_csv_data.count) if @csv_file.present?).to_i
        total_failed = invalid_email_fields + (current_user.invalid_csv_data.count if @csv_file.present?).to_i
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

    def download_csv
      current_user.update_attribute :csv_downloaded, true
      send_data current_user.to_csv(current_user.invalid_csv_data), filename: "invitee_list.csv", disposition: "attachment"
    end

    def download_sample_csv
      sample_csv = %w[ admin@gmail.com,admin employee@yahoo.com,employee hr@hotmail.com,hr ]
      send_data current_user.to_csv(sample_csv), filename: "sample.csv", disposition: "attachment"
    end

    private

    def allow_access
      authorize! :edit, Company
    end

    rescue_from CSV::MalformedCSVError do |exception|
      flash[:danger] = "Invalid CSV file."
      redirect_to office_automation_employee.new_user_invitation_path
    end
  end
end
