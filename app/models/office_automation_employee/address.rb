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

    embedded_in :company, class_name: 'OfficeAutomationEmployee::Company'
  end
end
