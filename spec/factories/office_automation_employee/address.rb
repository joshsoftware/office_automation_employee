module OfficeAutomationEmployee
  FactoryGirl.define do
    factory :address, aliases: [:registered_address, :current_address], class: Address do
      address "thube park"
      city "pune"
      pincode 411005
      state "Maharashtra"
      country "India"
      phone 9876543210
    end
  end
end
