module OfficeAutomationEmployee
  class UserMailer < ActionMailer::Base
    default from: "shweta@joshsoftware.com"

    def notification_email(company , user, updated_attributes)
      @updated_attributes = updated_attributes 
      @user = user
      @company = company
      @admins = @company.users.where(:roles.in => [Role::ADMIN])
      @admins.each do |admin|

        mail(to: admin.email, subject: "#{@user.profile.first_name} #{@user.profile.last_name} has updated his/her profile")
      end
    end
  end
end
