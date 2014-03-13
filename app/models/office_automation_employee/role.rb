module OfficeAutomationEmployee
  class Role
    include Mongoid::Document

    #Predifined roles which are added in db/seeds.rb
    ADMIN = 'Admin'
    HR = 'Hr' 
    EMPLOYEE = 'Employee'
    ACCOUNTANT = 'Accountant'

    ROLES = [ADMIN, HR, EMPLOYEE, ACCOUNTANT]

    field :name

    validates :name, presence: true

    has_and_belongs_to_many :companies, class_name: 'OfficeAutomationEmployee::Company'

  end
end
