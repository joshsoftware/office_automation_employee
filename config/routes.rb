OfficeAutomationEmployee::Engine.routes.draw do
  devise_for :users, :class_name => "OfficeAutomationEmployee::User"
end
