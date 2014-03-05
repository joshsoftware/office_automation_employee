module OfficeAutomationEmployee
  class Profile
    include Mongoid::Document

    field :first_name
    field :middle_name
    field :last_name
    field :designation
    field :gender
    field :mobile_number
    field :blood_group
    field :date_of_birth, type: Date
    field :skills, type: Array
    field :image

    # relationships
    embedded_in :user, class_name: 'OfficeAutomationEmployee::User', inverse_of: :profile

    # validations
    validates_uniqueness_of :mobile_number

  end
end
