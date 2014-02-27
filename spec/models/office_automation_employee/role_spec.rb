require 'spec_helper'

module OfficeAutomationEmployee
  describe Role do

    context 'It checks presence of fields' do
      it { expect have_field(:name) }
    end

    context 'It validates fields' do
      it { expect validate_presence_of(:name) }
    end

    context 'It checks for associations' do
      it { expect have_and_belong_to_many(:companies) }
    end

  end
end
