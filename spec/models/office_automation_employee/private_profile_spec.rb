require 'spec_helper'

module OfficeAutomationEmployee
  describe PrivateProfile do
    it { should have_fields(:pan_number, :personal_email, :passport_number, :qualification, :date_of_joining, :work_experience, :previous_company) }
    it { should have_field(:date_of_joining).of_type(Date) }
    it { should be_embedded_in(:user) }
    it { validate_uniqueness_of(:pan_number) }
    it { validate_uniqueness_of(:personal_email) }
    it { validate_uniqueness_of(:passport_number) }
  end
end
