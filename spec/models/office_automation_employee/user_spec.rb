require 'spec_helper'

module OfficeAutomationEmployee
  describe User do
    it { expect have_fields(:email, :encrypted_password, :role, :status) }
    it { expect embed_one :public_profile }
    it { expect embed_one :private_profile }
    it { expect belong_to :company }
    it { expect validate_presence_of(:role) }
    it { expect validate_presence_of(:email) }
  end
end
