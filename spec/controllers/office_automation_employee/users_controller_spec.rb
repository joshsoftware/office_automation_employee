require 'spec_helper'

module OfficeAutomationEmployee

  describe UsersController do
    include_engine_routes

    let(:admin) { create(:admin) }
    let(:user) { create(:user) }

    before(:each) do
      admin.confirm!
      sign_in admin
      user.invite!(admin)
      sign_out admin
      user.company=admin.company
      user.accept_invitation!
      sign_in user
    end

    context '#edit' do
      it 'Renders edit template' do
        get :edit, company_id: user.company,id: user
        expect(response).to render_template(:edit)
      end
    end

    context '#update' do
      it 'Updates profile' do
        put :update, user: {profile_attributes: {first_name: 'abcd', last_name: 'abc', mobile_number: 1234567890}}, company_id: user.company, id:user

        expect(user.reload.profile.first_name).to eq('abcd')
        expect(user.profile.last_name).to eq('abc')
        expect(user.profile.mobile_number).to eq(1234567890)
        expect(response).to be_redirect
      end

      it 'Will not update profile if mandatory field is empty' do

        put :update, user: {profile_attributes: {last_name: 'abc', mobile_number: 1234567890}}, company_id: user.company, id:user

        expect(response).to render_template(:edit)
      end

      it 'Updates personal profile' do
        put :update, user: { personal_profile_attributes:{same_as_permanent_address: true, permanent_address: {address: 'shivajinagar', city: 'pune', pincode: 12345, state: 'MH', country: 'India', phone: 1234567890}}}, company_id: user.company, id: user

        expect(user.reload.personal_profile.permanent_address.address).to eq(user.personal_profile.current_address.address)
        expect(user.personal_profile.permanent_address.city).to eq(user.personal_profile.current_address.city)
        expect(user.personal_profile.permanent_address.pincode).to eq(user.personal_profile.current_address.pincode)
        expect(user.personal_profile.permanent_address.state).to eq(user.personal_profile.current_address.state)
        expect(user.personal_profile.permanent_address.phone).to eq(user.personal_profile.current_address.phone)
      
      end
    end
  end
end
