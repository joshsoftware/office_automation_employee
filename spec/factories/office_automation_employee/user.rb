module OfficeAutomationEmployee  
  FactoryGirl.define do
    factory :user, class: User do
      email "user@gmail.com"
      password "12345678"
      password_confirmation "12345678"
      status "Pending"
      roles [Role::EMPLOYEE]

      factory :admin do
        company
        email "admin@domain.com"
        status "Active"
        roles [Role::ADMIN]
      end
    end
  end
end
