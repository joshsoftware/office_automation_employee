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

    # relationships
    embedded_in :user, class_name: 'OfficeAutomationEmployee::User', inverse_of: :personal_profile

    # validations
    validates_uniqueness_of :pan_number
    validates_uniqueness_of :personal_email
    validates_uniqueness_of :passport_number

  end
end
