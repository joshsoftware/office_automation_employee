require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class CompaniesController < ApplicationController
    
    def index
      @company = Company.all
      authorize! :manage, @company
    end

    def show
      redirect_to(office_automation_employee.companies_path) if can? :manage, OfficeAutomationEmployee::Company
      @company = current_user.company
    end

    def edit
      @company = Company.find params[:id]
      authorize! :edit, @company 
      @registered_address = @company.registered_address
      @current_address = @company.current_address
    end

    def update
      @company = Company.find params[:id]
      authorize! :edit, @company
      @registered_address = @company.registered_address
      @current_address = @company.current_address

      if @company.update_attributes company_params
        flash[:success] = "Profile updated successfully."
        redirect_to office_automation_employee.edit_company_path(@company)
      else
        flash[:danger] = "Please fill the fields accordingly."
        render :edit
      end
    end

    def destroy
      @company = Company.find params[:id]
      authorize! :manage, @company
      if @company.destroy
        redirect_to office_automation_employee.companies_path
      else
        flash[:notice] = "Some error occured while performing this action"
        render :index
      end
    end

    private

    def company_params
      params[:company].permit(:name, :registration_date, :company_url, :logo, :same_as_registered_address, registered_address: [:address, :pincode, :city, :state, :country, :phone], current_address: [:address, :pincode, :city, :state, :country, :phone])
    end
  end
end
