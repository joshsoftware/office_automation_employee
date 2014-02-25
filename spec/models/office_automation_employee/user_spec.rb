require 'spec_helper'

module OfficeAutomationEmployee
  describe User do
    it { should have_fields(:email, :encrypted_password, :role, :status) }
    it { should embed_one :public_profile }
    it { should embed_one :private_profile }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:email) }
  end
end
