OfficeAutomationEmployee::Role::ROLES.each do |role|
  OfficeAutomationEmployee::Role.find_or_create_by(name: role.humanize)
end

