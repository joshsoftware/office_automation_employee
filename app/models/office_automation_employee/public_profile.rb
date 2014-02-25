module OfficeAutomationEmployee
  class PublicProfile
    include Mongoid::Document
    field :first_name
    field :middle_name
    field :last_name
    field :designation
    field :gender
    field :mobile_number
    field :blood_group
    field :date_of_birth, :type => Date
    field :skills
    field :image

    # relationships
    embedded_in :user, class_name: 'OfficeAutomationEmployee::User', inverse_of: :public_profile

    # validations
    validates_uniqueness_of :mobile_number

  end
end
