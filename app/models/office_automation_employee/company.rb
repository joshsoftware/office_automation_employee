module OfficeAutomationEmployee
  class Company
    include Mongoid::Document
    include Mongoid::Slug

    mount_uploader :logo, FileUploader

    field :name
    slug :name

    field :logo
    field :registration_date, type: Date
    field :company_url  
    # If current address is same as registered address same_as flag will be true otherwise false
    field :same_as_registered_address, type: Boolean, default: false
    field :status

    validates :name, :registration_date, presence: true
    validates :name, uniqueness: true


    embeds_one :registered_address, class_name: 'OfficeAutomationEmployee::Address'
    embeds_one :current_address, class_name: 'OfficeAutomationEmployee::Address'
    
    has_and_belongs_to_many :roles, class_name: 'OfficeAutomationEmployee::Role'
    has_many :users, class_name: 'OfficeAutomationEmployee::User', dependent: :destroy
    
    accepts_nested_attributes_for :users
    before_update :delete_address

    accepts_nested_attributes_for :users

    private

    # If current address is same as registered address then update current address
    def delete_address
     
      if same_as_registered_address
        self.current_address = nil if self.current_address?
      end
   
    end
  end
end
