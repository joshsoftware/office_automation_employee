require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class UsersController < ApplicationController
    def index
      @company = Company.find params[:company_id]
    end

    def show
      @user = User.find params[:id]
    end

    def edit
    end

    def update
    end

    def destroy
      User.find(params[:id]).destroy
      redirect_to office_automation_employee.company_users_path(params[:company_id])
    end

    def invite
      if User.find(params[:id]).invite!(current_user)
        flash[:notice] = "Invitation sent successfully..."
        redirect_to office_automation_employee.company_user_path params[:company_id], params[:id]
      else
        flash[:danger] = "Invitation not sent..."
      end
    end
  end
end
