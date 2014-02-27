OfficeAutomationEmployee::Engine.routes.draw do

  devise_for :users, :class_name => "OfficeAutomationEmployee::User", module: :devise, controllers: { registrations: "office_automation_employee/registrations", sessions: 'office_automation_employee/sessions' }

end
