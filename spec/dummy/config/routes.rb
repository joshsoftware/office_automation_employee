Rails.application.routes.draw do
  mount OfficeAutomationEmployee::Engine => '/office_automation_employee'
  root to: 'office_automation_employee/users#index'
end
