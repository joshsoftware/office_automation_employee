module OfficeAutomationEmployee
  class Company
    include Mongoid::Document

    field :name
    field :logo
    field :registration_date, type: Date
    field :company_url  

    validates :name, presence: true
    validates :name, uniqueness: true

    embeds_one :registered_address, class_name: 'OfficeAutomationEmployee::Address'
    embeds_one :current_address, class_name: 'OfficeAutomationEmployee::Address'
    has_and_belongs_to_many :roles, class_name: 'OfficeAutomationEmployee::Role'

  end
end
