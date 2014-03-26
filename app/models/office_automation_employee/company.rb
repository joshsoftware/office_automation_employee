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

    validates :name, :registration_date, presence: true
    validates :name, uniqueness: true


    embeds_one :registered_address, class_name: 'OfficeAutomationEmployee::Address'
    embeds_one :current_address, class_name: 'OfficeAutomationEmployee::Address'
    
    has_and_belongs_to_many :roles, class_name: 'OfficeAutomationEmployee::Role'
    has_many :users, class_name: 'OfficeAutomationEmployee::User', dependent: :destroy
    
    accepts_nested_attributes_for :users
    before_validation :save_address

    accepts_nested_attributes_for :users

    private

    # If current address is same as registered address then update current address
    def save_address
     
      if same_as_registered_address
        self.current_address = Address.new(address: registered_address.address, pincode: registered_address.pincode, city: registered_address.city, state: registered_address.state, country: registered_address.country, phone: registered_address.phone)
      end
   
    end
  end
end
