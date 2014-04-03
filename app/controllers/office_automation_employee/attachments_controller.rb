require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class AttachmentsController < ApplicationController
    def destroy
      @user = User.find(params[:user_id])
      @attachment = @user.attachments.find(params[:id])
      @attachment.remove_document
      if @attachment.destroy
        flash[:success] = 'Document Deleted Succesfully'
        redirect_to office_automation_employee.edit_company_user_path(current_user.company, current_user)
      else
        flash[:danger] = 'Unable to update profile'
        render office_automation_employee.edit_company_user_path(current_user.company, current_user)
      end
    end

    def download_document
      @user = User.find(params[:user_id])
      @attachment = @user.attachments.find(params[:id])
      document_type = MIME::Types.type_for(@attachment.document.url).first.content_type
      send_file @attachment.document.path, filename: File.basename(@attachment.document.url), type: "#{document_type}"
    end
  end
end
