module OfficeAutomationEmployee
  class User 
    include Mongoid::Document
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :invitable, :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :confirmable, :validatable

    mount_uploader :image, FileUploader

    ## Database authenticatable
    field :email,              :default => ""
    field :encrypted_password, :default => ""

    ## Recoverable
    field :reset_password_token
    field :reset_password_sent_at

    ## Rememberable
    field :remember_created_at, :type => Time

    ## Trackable
    field :sign_in_count,      :type => Integer, :default => 0
    field :current_sign_in_at, :type => Time
    field :last_sign_in_at,    :type => Time
    field :current_sign_in_ip
    field :last_sign_in_ip

    ## Confirmable
    field :confirmation_token
    field :confirmed_at,         :type => Time
    field :confirmation_sent_at, :type => Time
    field :unconfirmed_email # Only if using reconfirmable

    ## Invitable
    field :invitation_token
    field :invitation_created_at, type: Time
    field :invitation_sent_at, type: Time
    field :invitation_accepted_at, type: Time
    field :invitation_limit, type: Integer

    index( {invitation_token: 1}, { background: true } )
    index( {invitation_by_id: 1}, { background: true } )

    ## Lockable
    # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
    # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
    # field :locked_at,       :type => Time

    # user-fields
    field :status, default: 'Pending'
    field :role, type: Array

    field :image
    # validations
    validates :role, presence: true

    # relationships
    embeds_one :profile, class_name: 'OfficeAutomationEmployee::Profile'
    embeds_one :personal_profile, class_name: 'OfficeAutomationEmployee::PersonalProfile'
    belongs_to :company, class_name: 'OfficeAutomationEmployee::Company'

    accepts_nested_attributes_for :profile
    accepts_nested_attributes_for :personal_profile
  end
end
