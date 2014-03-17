require 'spec_helper'

module OfficeAutomationEmployee
  describe User do

    context 'It checks for presence of fields' do
      it { should have_fields(:email, :encrypted_password, :roles, :status,:image) }
    end

    context 'It validates fields' do
      it { should validate_presence_of(:roles) }
      it { should validate_presence_of(:email) }
    end

    context 'It checks for associations' do
      it { should embed_one :profile }
      it { should embed_one :personal_profile }
      it { should belong_to :company }
    end
  end
end
