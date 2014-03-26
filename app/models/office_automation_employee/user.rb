require 'csv'

module OfficeAutomationEmployee
  class User 
    include Mongoid::Document
    include Mongoid::Search
    #Send mail when user updates following fields
    UPDATED_FIELDS = ['image', 'date_of_joining', 'designation']

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :invitable, :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :confirmable, :validatable, :async

    mount_uploader :image, FileUploader

    ## Database authenticatable
    field :email,              default: ""
    field :encrypted_password, default: ""

    ## Recoverable
    field :reset_password_token
    field :reset_password_sent_at

    ## Rememberable
    field :remember_created_at, type: Time

    ## Trackable
    field :sign_in_count,      type: Integer, default: 0
    field :current_sign_in_at, type: Time
    field :last_sign_in_at,    type: Time
    field :current_sign_in_ip
    field :last_sign_in_ip

    ## Confirmable
    field :confirmation_token
    field :confirmed_at,         type: Time
    field :confirmation_sent_at, type: Time
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
    field :roles, type: Array

    field :image
    # validations
    validates :roles, presence: true

    # relationships
    embeds_one :profile, class_name: 'OfficeAutomationEmployee::Profile'
    embeds_one :personal_profile, class_name: 'OfficeAutomationEmployee::PersonalProfile'
    belongs_to :company, class_name: 'OfficeAutomationEmployee::Company'
    embeds_many :attachments, class_name: 'OfficeAutomationEmployee::Attachment', cascade_callbacks: true

    accepts_nested_attributes_for :profile
    accepts_nested_attributes_for :personal_profile
    accepts_nested_attributes_for :attachments

    search_in :email, profile: :first_name, profile: :last_name
   
    after_update :send_mail
    def role?(role)
      self.roles.include? role.humanize
    end

    def invite_by_fields(fields)
      invalid_email_present = 0
      fields.each_value do |invitee|
        if invitee[:_destroy] == 'false'
          user = self.company.users.create email: invitee[:email], roles: [Role.find(invitee[:roles]).name]
          user.errors.messages.keys.include?(:email) ? invalid_email_present += 1 : user.invite!(self)
        end
      end
      invalid_email_present
    end

    def invite_by_csv(file)
      invalid_rows = Array.new
      CSV.foreach(file.path, headers: true) do |row|
        if row.headers != ["email", "roles"] or row["roles"].nil? or Role.where(name: row["roles"].humanize).none?
          invalid_rows.push row.to_s.chomp + " [row:#{$.}]" if row.present?
          next
        end

        user = self.company.users.create email: row["email"], roles: [row["roles"].humanize]
        user.errors.messages.keys.include?(:email) ? invalid_rows.push(row.to_s.chomp + " [row:#{$.}]") : user.invite!(self)
      end
      [invalid_rows, $. - 1]  # $. is last row number from file
    end

    def send_mail

      personal_profile_changes = self.personal_profile ? self.personal_profile.changes : {}
      profile_changes = self.profile ? self.profile.changes : {}
      @updated_attributes = self.changes.merge(personal_profile_changes).merge(profile_changes)
      @updated_attributes.reject!{|k,v| !UPDATED_FIELDS.include? k}
      UserMailer.notification_email(self.company, self, @updated_attributes).deliver unless @updated_attributes.length.eql?(0)

    end
  end
end
