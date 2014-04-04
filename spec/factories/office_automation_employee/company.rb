module OfficeAutomationEmployee
  FactoryGirl.define do
    factory :company, class: Company do
      name "josh"
      company_url "http://www.josh.com"
      registration_date "01/01/2007"
      registered_address { FactoryGirl.build(:registered_address) }
      current_address { FactoryGirl.build(:current_address) }
      roles Role.all
      status "Active"
    end
  end
end
