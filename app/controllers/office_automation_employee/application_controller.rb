module OfficeAutomationEmployee
  class ApplicationController < ActionController::Base
    before_filter :authenticate_user!

    rescue_from CanCan::AccessDenied do |exception|
      flash[:danger] = "You are not allowed to perform this action."
      redirect_to main_app.root_path
    end
  end
end
