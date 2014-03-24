require 'spec_helper'

module OfficeAutomationEmployee
  describe Attachment do
  
    context 'It checks presence of fields' do
      it { should have_fields(:name, :document) }
    end

    context 'It checks for associations' do
      it { should be_embedded_in(:user) }
    end
  end
end
