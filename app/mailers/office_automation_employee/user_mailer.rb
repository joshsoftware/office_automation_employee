module OfficeAutomationEmployee
  class UserMailer < ActionMailer::Base
    default from: "shweta@joshsoftware.com"

    def notification_email(company , user, updated_attributes)
      @updated_attributes = updated_attributes 
      @user = user
      @company = company
      recipients = @company.users.where(:roles.in => [Role::ADMIN]).map(&:email)  
      mail(to: recipients, subject: "#{@user.profile.first_name} #{@user.profile.last_name} has updated profile")
    end

    def password_update_email(user)
      @user = user
      mail(to: user.email, subject: "#{@user.company.name} Password change")
    end
  end
end
