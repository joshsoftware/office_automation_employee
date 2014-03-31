# desc "Explaining what the task does"
# task :office_automation_employee do
#   # Task goes here
# end
#
#
namespace :db do
  task load_seed: [:environment] do

    address = {address: 'Shivajinagar', city: 'Pune', pincode: '411005', state: 'Maharashtra', country: 'India', phone: '02012345678'}
    first_name = ['Rita', 'John', 'Jay', 'Neha', 'Aamir']
    last_name = ['Singh', 'Khan', 'Pinto', 'Jain']
    blood_group = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
    date = ['1992/11/11', '1980/10/11', '1990/12/12', '1978/12/10', '1988/09/09']
    skills = ['Ruby On rails', 'Testing', 'Designing', 'Database']
    designation = ['Quality Analyst', 'Software Developer', 'Senior software developer', 'Trainee']
    number = ['qw1234rew3', 'lp09jlpu78', 'bn67hgf5ty', 'fgu5tu7io9', 'dfg678hgf6'] #For pan card / Passport number
    qualification = ['B.E', 'M.C.A', 'M.Tech', 'M.C.S']
    previous_company = ['Spring', 'Quickheal', 'Herbinger', 'Omniscient']
    mobile_number = 9870000000
    password = '1234567890'

    email_josh = ['user@josh.com', 'user1@josh.com', 'user2@josh.com', 'user3@josh.com', 'user4@josh.com', 'user5@josh.com', 'user6@josh.com', 'user7@josh.com', 'user8@josh.com', 'user9@josh.com', 'user10@josh.com', 'user11@josh.com', 'user12@josh.com']

    email_sancheti = ['user@sancheti.com', 'user1@sancheti.com', 'user2@sancheti.com', 'user3@sancheti.com', 'user4@sancheti.com', 'user5@sancheti.com', 'user6@sancheti.com', 'user7@sancheti.com', 'user8@sancheti.com', 'user9@sancheti.com', 'user10@sancheti.com', 'user11@sancheti.com', 'user12@sancheti.com']

    company = OfficeAutomationEmployee::Company.find_or_create_by(name: 'Josh software private limited', registration_date: '2007/01/01', registered_address: {address: '6 Thube Park, Shivajinagar', city: 'Pune', pincode: '411005', state: 'Maharashtra', country: 'India', phone: '02025539995'}, same_as_registered_address: true)


    company1 = OfficeAutomationEmployee::Company.find_or_create_by(name: 'sancheti', registration_date: '2008/01/01', registered_address: {address: '6 Thube Park, Shivajinagar', city: 'Pune', pincode: '411005', state: 'Maharashtra', country: 'India', phone: '02025539900'}, same_as_registered_address: false, current_address: address, same_as_registered_address: false)

    company.roles = OfficeAutomationEmployee::Role.all
    company1.roles = OfficeAutomationEmployee::Role.all

    admin = OfficeAutomationEmployee::User.new(email: 'admin@josh.com', password: '1234567890', roles: [OfficeAutomationEmployee::Role::ADMIN], company_id: company._id, status: 'Active' )
    admin.skip_confirmation!


    admin.save

    admin.profile = OfficeAutomationEmployee::Profile.new(first_name: first_name.sample, last_name: last_name.sample, blood_group: blood_group.sample, date_of_birth: date.sample, skills: skills.sample, designation: designation.sample, mobile_number: mobile_number+1)

    admin.personal_profile = OfficeAutomationEmployee::PersonalProfile.new(pan_number: number.sample, date_of_joining: date.sample, passport_number: number.sample, qualification: qualification.sample, previous_company: previous_company.sample, permanent_address: address, same_as_permanent_address: true)

    admin.save


    admin = OfficeAutomationEmployee::User.new(email: 'admin@sancheti.com', password: '1234567890', roles: [OfficeAutomationEmployee::Role::ADMIN], company_id: company1._id, status: 'Active' )
    admin.skip_confirmation!
    admin.save
    admin.profile = OfficeAutomationEmployee::Profile.new(first_name: first_name.sample, last_name: last_name.sample, blood_group: blood_group.sample, date_of_birth: date.sample, skills: skills.sample, designation: designation.sample, mobile_number: mobile_number+1)

    admin.personal_profile = OfficeAutomationEmployee::PersonalProfile.new(pan_number: number.sample, date_of_joining: date.sample, passport_number: number.sample, qualification: qualification.sample, previous_company: previous_company.sample, permanent_address: address, same_as_permanent_address: true)

    admin.save

    email_josh.each do |email|
      user = OfficeAutomationEmployee::User.invite!(email: email, roles: [OfficeAutomationEmployee::Role::ROLES.sample], company_id: company._id, status: 'Active') do |u|
        u.skip_invitation = true
      end
      token = Devise::VERSION >= "3.1.0" ? user.instance_variable_get(:@raw_invitation_token) : user.invitation_token
      OfficeAutomationEmployee::User.accept_invitation!(:invitation_token => token, :password => password, :password_confirmation => password)

      user.profile = OfficeAutomationEmployee::Profile.new(first_name: first_name.sample, last_name: last_name.sample, blood_group: blood_group.sample, date_of_birth: date.sample, skills: skills.sample, designation: designation.sample, mobile_number: mobile_number+1)

      user.personal_profile = OfficeAutomationEmployee::PersonalProfile.new(pan_number: number.sample, date_of_joining: date.sample, passport_number: number.sample, qualification: qualification.sample, previous_company: previous_company.sample, permanent_address: address, same_as_permanent_address: true)

      user.save
    end

    email_sancheti.each do |email|
      user = OfficeAutomationEmployee::User.invite!(email: email, roles: [OfficeAutomationEmployee::Role::ROLES.sample], company_id: company1._id, status: 'Active') do |u|
        u.skip_invitation = true
      end
      token = Devise::VERSION >= "3.1.0" ? user.instance_variable_get(:@raw_invitation_token) : user.invitation_token
      OfficeAutomationEmployee::User.accept_invitation!(:invitation_token => token, :password => password, :password_confirmation => password)

      user.profile = OfficeAutomationEmployee::Profile.new(first_name: first_name.sample, last_name: last_name.sample, blood_group: blood_group.sample, date_of_birth: date.sample, skills: skills.sample, designation: designation.sample, mobile_number: mobile_number+1)

      user.personal_profile = OfficeAutomationEmployee::PersonalProfile.new(pan_number: number.sample, date_of_joining: date.sample, passport_number: number.sample, qualification: qualification.sample, previous_company: previous_company.sample,permanent_address: address, same_as_permanent_address: true)

      user.save
    end

  end
end
