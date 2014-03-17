module OfficeAutomationEmployee
  class PersonalProfile
    include Mongoid::Document

    field :pan_number
    field :personal_email
    field :passport_number
    field :qualification
    field :date_of_joining, type: Date
    field :work_experience
    field :previous_company
    field :same_as_permanent_address, type: Boolean, default: false

    # relationships
    embedded_in :user, class_name: 'OfficeAutomationEmployee::User', inverse_of: :personal_profile
    embeds_one :permanent_address, class_name: 'OfficeAutomationEmployee::Address'
    embeds_one :current_address, class_name: 'OfficeAutomationEmployee::Address'

    # validations
    validates_uniqueness_of :pan_number
    validates_uniqueness_of :personal_email
    validates_uniqueness_of :passport_number

    before_validation :save_address

    private
    
    def save_address
      if same_as_permanent_address
        self.current_address = self.permanent_address.dup if self.permanent_address?
      end
    end
  
  end
end
