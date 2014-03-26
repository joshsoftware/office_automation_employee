require 'csv'

module OfficeAutomationEmployee
  class User 
    include Mongoid::Document
    include Mongoid::Slug

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :invitable, :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :confirmable, :validatable, :async

    mount_uploader :image, FileUploader

    ## Database authenticatable
    field :email,              default: ""
    slug :username
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
    field :invalid_csv_data, type: Array
    field :csv_downloaded, type: Boolean, default: true
    field :image
    # validations
    validates :roles, presence: true

    # relationships
    embeds_one :profile, class_name: 'OfficeAutomationEmployee::Profile'
    embeds_one :personal_profile, class_name: 'OfficeAutomationEmployee::PersonalProfile'
    belongs_to :company, class_name: 'OfficeAutomationEmployee::Company'

    accepts_nested_attributes_for :profile
    accepts_nested_attributes_for :personal_profile

    def role?(role)
      roles.include? role.humanize
    end

    def username
      email.split('@')[0]
    end

    def fullname
      "#{profile.first_name} #{profile.middle_name} #{profile.last_name}" unless profile.nil?
    end

    def invite_by_fields(fields)
      invalid_email_count, total_email_fields = 0, 0
      fields.each_value do |invitee|
        if invitee[:_destroy] == 'false'
          user = company.users.create email: invitee[:email], roles: [Role.find(invitee[:roles]).name]
          user.errors.messages.keys.include?(:email) ? invalid_email_count += 1 : user.invite!(self)
          total_email_fields += 1
        end
      end
      [invalid_email_count, total_email_fields]
    end

    def invite_by_csv(file)
      update_attributes csv_downloaded: true, invalid_csv_data: Array.new
      CSV.foreach(file.path, headers: true) do |row|
        if row.headers != ["email", "roles"] or row["roles"].nil? or Role.where(name: row["roles"].humanize).none?
          push(invalid_csv_data: row.to_s.chomp) if row.present?
          next
        end

        user = company.users.create email: row["email"], roles: [row["roles"].humanize]
        user.errors.messages.keys.include?(:email) ? push(invalid_csv_data: row.to_s.chomp) : user.invite!(self)
      end
      update_attributes csv_downloaded: false if invalid_csv_data.present?
      $. - 1  # $. is last row number from csv file
    end

    def to_csv csv_data
      CSV.generate do |csv|
        csv << ["email", "roles"]
        csv_data.each do |row|
          csv << row.split(',')
        end
      end
    end
  end
end
