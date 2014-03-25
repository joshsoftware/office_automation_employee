require 'sidekiq/web'

OfficeAutomationEmployee::Engine.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  resources :companies, except: ['new', 'create'] do
    resources :users, except: ['new', 'create'] do
      resources :attachments, only: ['destroy'] do
        get :download_document, on: :member
      end
      get 'invite', on: :member
    end
  end

  devise_for :users, class_name: "OfficeAutomationEmployee::User", module: :devise, controllers: {
    registrations: "office_automation_employee/registrations", 
    sessions: 'office_automation_employee/sessions', 
    passwords: 'office_automation_employee/passwords', 
    confirmations: 'office_automation_employee/confirmations',
    invitations: 'office_automation_employee/invitations'
  }
end
