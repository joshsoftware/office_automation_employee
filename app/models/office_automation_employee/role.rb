module OfficeAutomationEmployee
  class Role
    include Mongoid::Document
 
    field :name

    validates :name, presence: true

    has_and_belongs_to_many :companies
  
  end
end
