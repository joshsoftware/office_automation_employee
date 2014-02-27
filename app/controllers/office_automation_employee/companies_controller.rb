require_dependency "office_automation_employee/application_controller"

module OfficeAutomationEmployee
  class CompaniesController < ApplicationController
    def new
      @company = Company.new
    end

    def create
      @company = Company.new(permit_company_params)
      puts @company
      if @company.save!
        puts "saved"
      else
        puts "unable to save"
      end
    end

    private
    def permit_company_params
      params.require(:company).permit(:name, :registration_date, :logo, registered_address: [:address, :pincode, :city, :state, :country, :phone], current_address: [:address, :pincode, :city, :state, :country, :phone] )
    end
  end
end
