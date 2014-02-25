require 'spec_helper'

module OfficeAutomationEmployee
  describe Role do

    context 'It checks presence of fields' do
      it { should have_field(:name).of_type(String) }
    end

    context 'It validates fields' do
      it { should validate_presence_of(:name) }
    end

    context 'It checks for associations' do
      it { should have_and_belong_to_many(:companies) }
    end

  end
end
