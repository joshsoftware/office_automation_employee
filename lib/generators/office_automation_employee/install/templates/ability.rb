class Ability < OfficeAutomationEmployee::Ability
  include CanCan::Ability

  def initialize(user)
    super
  end
end
