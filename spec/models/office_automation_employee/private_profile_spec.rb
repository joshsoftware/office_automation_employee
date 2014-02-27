require 'spec_helper'

module OfficeAutomationEmployee
  describe PrivateProfile do
    it { expect have_fields(:pan_number, :personal_email, :passport_number, :qualification, :date_of_joining, :work_experience, :previous_company) }
    it { expect have_field(:date_of_joining).of_type(Date) }
    it { expect be_embedded_in(:user) }
    it { expect validate_uniqueness_of(:pan_number) }
    it { expect validate_uniqueness_of(:personal_email) }
    it { expect validate_uniqueness_of(:passport_number) }
  end
end
