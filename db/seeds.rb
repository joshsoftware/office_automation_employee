module OfficeAutomationEmployee
  # creating superadmin
  superadmin = User.new(email: "superadmin@domain.com", password: "abcdabcd", roles: ["Superadmin"], status: "Active")
  superadmin.skip_confirmation!
  superadmin.save

  # Retreive array of ROLES (Constant) from Role model and add roles in database
  Role::ROLES.each do |role|
    Role.find_or_create_by(name: role.humanize)
  end
end
