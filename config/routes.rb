OfficeAutomationEmployee::Engine.routes.draw do
  resources :companies
  devise_for :users, class_name: "OfficeAutomationEmployee::User", module: :devise, controllers: {
    registrations: "office_automation_employee/registrations", 
    sessions: 'office_automation_employee/sessions', 
    passwords: 'office_automation_employee/passwords', 
    confirmations: 'office_automation_employee/confirmations'
  }
end
