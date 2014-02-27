require 'spec_helper'

module OfficeAutomationEmployee
  describe Address do
   
    context 'It checks presence of fields' do
      it { expect have_fields(:address, :city, :country, :state) }
      it { expect have_fields(:pincode, :phone).of_type(Integer) }
    end

    context 'It validates fields' do
      it { expect validate_presence_of(:address) }
      it { expect validate_presence_of(:city) }
      it { expect validate_presence_of(:pincode) }
      it { expect validate_presence_of(:country) }
      it { expect validate_presence_of(:state) }
      it { expect validate_presence_of(:phone) }
      it { expect validate_numericality_of(:pincode).on(:create, :update) }
      it { expect validate_numericality_of(:phone).on(:create, :update) }
    end

    context 'It checks for associations' do
      it { expect be_embedded_in(:registered_address) }
      it { expect be_embedded_in(:current_address) }
    end

  end
end
