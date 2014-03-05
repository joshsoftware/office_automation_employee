require 'spec_helper'

module OfficeAutomationEmployee
  describe Company do

    context 'It checks presence of fields' do
      it { expect have_fields(:name, :logo, :company_url) }
      it { expect have_field(:registration_date).of_type(Date) }
    end

    context 'It validates fields' do
      it { expect validate_presence_of(:name) }
      it { expect validate_presence_of(:registration_date) }
      it { expect validate_uniqueness_of(:name) }
    end

    context 'It checks for associations' do
      it { expect embed_one (:registered_address) }
      it { expect embed_one (:current_address) }
      it { expect have_many (:users) }
      it { expect have_and_belong_to_many (:roles) }
    end
  end
end
