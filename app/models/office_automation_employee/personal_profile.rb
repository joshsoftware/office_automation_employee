module OfficeAutomationEmployee
  class PersonalProfile
    include Mongoid::Document

    field :pan_number
    field :personal_email
    field :passport_number
    field :qualification
    field :date_of_joining, type: Date
    field :work_experience, type: Integer, default: 0
    field :previous_company
    field :same_as_permanent_address, type: Boolean, default: false

    # relationships
    embedded_in :user, class_name: 'OfficeAutomationEmployee::User', inverse_of: :personal_profile
    embeds_one :permanent_address, class_name: 'OfficeAutomationEmployee::Address'
    embeds_one :current_address, class_name: 'OfficeAutomationEmployee::Address'

    # validations
    validates :pan_number, uniqueness: true, length: { maximum: 13, minimum: 10 }, allow_blank: true
    validates :personal_email, uniqueness: true
    validates :work_experience, numericality: true, length: {maximum: 2}
    validates :passport_number, uniqueness: true, length: { maximum: 10, minimum: 8 }, allow_blank: true

    after_validation :delete_address

    private
    
    def delete_address
      if same_as_permanent_address
        self.current_address = nil if self.current_address?
      end
    end
  
  end
end
