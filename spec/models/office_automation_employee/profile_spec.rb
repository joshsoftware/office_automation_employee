require 'spec_helper'

module OfficeAutomationEmployee
  describe Profile do

    context 'It checks presence of fields' do
      it { should have_fields(:first_name, :middle_name, :last_name, :gender, :mobile_number, :blood_group, :date_of_birth, :skills, :designation) }
    end

    context 'It validates fields' do

      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:mobile_number) }
      it { should validate_uniqueness_of(:mobile_number) } 
    end

    context 'It checks for associations' do
      it { should be_embedded_in(:user) }
    end
  end
end
