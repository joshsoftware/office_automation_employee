module OfficeAutomationEmployee
  class Role
    include Mongoid::Document
 
    field :name, type: String

    validates :name, presence: true

    has_and_belongs_to_many :companies
  
  end
end
