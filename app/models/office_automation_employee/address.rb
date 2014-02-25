module OfficeAutomationEmployee
  class Address
    include Mongoid::Document

    field :address, type: String
    field :city, type: String
    field :pincode, type: Integer
    field :state, type: String
    field :country, type: String
    field :phone, type: Integer

    validates :address, :city, :pincode, :state, :country, :phone, presence: true
    validates :pincode, :phone, numericality:true

    embedded_in :registered_address, class_name: 'OfficeAutomationEmployee::Company'
    embedded_in :current_address, class_name: 'OfficeAutomationEmployee::Company'
  
  end
end
