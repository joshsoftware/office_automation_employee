module OfficeAutomationEmployee
  class Ability
    include CanCan::Ability

    def initialize(current_user)
      if current_user.role? Role::ADMIN
        can [:edit, :update], Company do |company|
          company == current_user.company
        end

        can :manage, User do |user|
          user.company == current_user.company
        end

      elsif current_user.role? Role::SUPER_ADMIN
        can :manage, :all

      else
        can [:edit, :update], User do |user|
          user == current_user
        end
      
        can [:index, :show], User do |user|
          user.company == current_user.company
        end
      end
    end
  end
end
