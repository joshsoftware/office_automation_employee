require 'spec_helper'

module OfficeAutomationEmployee
  describe Address do
   
    context 'It checks presence of fields' do
      it { should have_field(:address).of_type(String) }
      it { should have_field(:city).of_type(String) }
      it { should have_field(:pincode).of_type(Integer) }
      it { should have_field(:country).of_type(String) }
      it { should have_field(:state).of_type(String) }
      it { should have_field(:phone).of_type(Integer) }
    end

    context 'It validates fields' do
      it { should validate_presence_of(:address) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:pincode) }
      it { should validate_presence_of(:country) }
      it { should validate_presence_of(:state) }
      it { should validate_presence_of(:phone) }
      it { should validate_numericality_of(:pincode).on(:create, :update) }
      it { should validate_numericality_of(:phone).on(:create, :update) }
    end

    context 'It checks for associations' do
      it { should be_embedded_in(:registered_address) }
      it { should be_embedded_in(:current_address) }
    end

  end
end
