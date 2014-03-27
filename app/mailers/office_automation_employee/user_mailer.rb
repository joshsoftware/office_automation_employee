module OfficeAutomationEmployee
  class UserMailer < ActionMailer::Base
    default from: "shweta@joshsoftware.com"

    def notification_email(company , user, updated_attributes)
      @updated_attributes = updated_attributes 
      @user = user
      @company = company
      @admins = @company.users.where(:roles.in => [Role::ADMIN])
      recipients = []
      @admins.each do |admin|
        recipients << admin.email
      end
        mail(to: recipients, subject: "#{@user.profile.first_name} #{@user.profile.last_name} has updated profile")
    end
  end
end
