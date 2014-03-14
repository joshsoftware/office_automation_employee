module OfficeAutomationEmployee
  class Ability
    include CanCan::Ability

    def initialize(user)
      if user.role? Role::ADMIN
        can :manage, :all
      else
        can :read, :all
      end
    end
  end
end
