Rails.application.routes.draw do
  mount OfficeAutomationEmployee::Engine => '/employee'
  root to: 'office_automation_employee/companies#show'
end
