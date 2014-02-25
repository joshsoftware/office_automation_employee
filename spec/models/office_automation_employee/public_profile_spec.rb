require 'spec_helper'

module OfficeAutomationEmployee
  describe PublicProfile do
    it { should have_fields(:first_name, :middle_name, :last_name, :gender, :mobile_number, :blood_group, :date_of_birth, :skills, :designation, :image) }
    it { should be_embedded_in(:user) }
    it { validate_uniqueness_of(:mobile_number)}	
  end
end
