module OfficeAutomationEmployee
  class Profile
    include Mongoid::Document

    mount_uploader :file, FileUploader 
    
    field :first_name
    field :middle_name
    field :last_name
    field :designation
    field :gender
    field :mobile_number, type: Integer
    field :blood_group
    field :date_of_birth, type: Date
    field :skills

    # relationships
    embedded_in :user, class_name: 'OfficeAutomationEmployee::User', inverse_of: :profile

    # validations
    validates :first_name, :last_name, :mobile_number , presence: true
    validates :mobile_number, {numericality:true, uniqueness: true, length: {minimum: 10, maximum: 13}}

  end
end
