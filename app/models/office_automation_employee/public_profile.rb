module OfficeAutomationEmployee
  class PublicProfile
    include Mongoid::Document
    field :first_name, type: String, default: ''
    field :middle_name, type: String, default: ''
    field :last_name, type: String, default: ''
    field :designation
    field :gender
    field :mobile_number, type: String
    field :blood_group, type: String
    field :date_of_birth, :type => Date
    field :skills
    field :image

    # relationships
    embedded_in :user, class_name: 'OfficeAutomationEmployee::User', inverse_of: :public_profile

    # validations
    validates_uniqueness_of :mobile_number

  end
end
