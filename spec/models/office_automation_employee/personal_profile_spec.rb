require 'spec_helper'

module OfficeAutomationEmployee
  describe PersonalProfile do
    context 'It checks for presence of fields' do
      it { should have_fields(:pan_number, :personal_email, :passport_number, :qualification, :work_experience, :previous_company) }
      it { should have_field(:same_as_permanent_address).of_type(Mongoid::Boolean).with_default_value_of(false) }
      it { should have_field(:date_of_joining).of_type(Date) }
    end

    describe 'It validates fields' do
      it { should validate_uniqueness_of(:pan_number) }
      it { should validate_uniqueness_of(:personal_email) }
      it { should validate_uniqueness_of(:passport_number) }
      it { should validate_numericality_of(:work_experience) }
      it { should validate_length_of(:pan_number).within(10..13) }
      it { should validate_length_of(:passport_number).within(8..10) }
    end

    describe 'It checks for associations' do
      it { should be_embedded_in(:user) }
      it { should embed_one(:permanent_address) }
      it { should embed_one(:current_address) }
    end
  end
end
