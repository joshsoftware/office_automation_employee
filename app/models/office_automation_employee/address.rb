module OfficeAutomationEmployee
  class Address
    include Mongoid::Document

    field :address
    field :city
    field :pincode, type: Integer
    field :state
    field :country
    field :phone, type: Integer

    validates :address, :city, :pincode, :state, :country, :phone, presence: true
    validates :pincode, :phone, numericality:true

    embedded_in :registered_address, class_name: 'OfficeAutomationEmployee::Company'
    embedded_in :current_address, class_name: 'OfficeAutomationEmployee::Company'

    embedded_in :permanent_address, class_name: 'OfficeAutomationEmployee::User'
    embedded_in :current_address, class_name: 'OfficeAutomationEmployee::User'
  end
end
