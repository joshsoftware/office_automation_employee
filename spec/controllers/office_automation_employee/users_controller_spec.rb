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

    context '#index' do
      it 'renders index template' do
        get :index, company_id: user.company
        expect(response).to render_template(:index)
      end
    end

    context '#show' do
      it 'renders show template' do
        get :show, company_id: user.company, id: user
        expect(response).to render_template(:show)
      end
    end

    context '#edit' do
      it 'Renders edit template' do
        get :edit, company_id: user.company,id: user
        expect(response).to render_template(:edit)
      end
    end

    context '#update' do
      before :each do
      @file = Rack::Test::UploadedFile.new("#{Engine.root}/spec/index.jpeg", "image/jpeg")

      end

      it 'Updates profile' do
        put :update, user: {profile_attributes: {first_name: 'abcd', last_name: 'abc', mobile_number: 1234567890, upload: @file}}, company_id: user.company, id:user

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

      it 'Uploads documents' do
        
        @f = Rack::Test::UploadedFile.new("#{Engine.root}/spec/neukirchen07introducingrack.pdf", "text/pdf")
        put :update, user: { attachments_attributes: { "0" => { document: @f , _destroy: "false"} } }, company_id: user.company, id: user
        expect(user.reload.attachments.count).to eq(1)

      end

      it 'Will not upload document if document size is greater than 10 MB' do

        @f = Rack::Test::UploadedFile.new("#{Engine.root}/spec/Head First jQuery.pdf", "text/pdf")
       
        put :update, user: { attachments_attributes: { "0" => {document: @f, _destroy: "false"} } }, company_id: user.company, id: user

        expect(user.reload.attachments.count).to eq(0)
      end

    end
    
    context '#destroy' do
      it 'removes user from company' do
        delete :destroy, company_id: user.company, id: user
        expect(User.count).to eq(1)
        expect(response).to redirect_to company_users_path
      end
    end

    context '#resend_invitation' do
      it 'resends invitation to user' do
        get :resend_invitation, company_id: user.company, id: user
        expect(user.reload.invitation_token).not_to be_nil
        expect(response).to redirect_to company_user_path
      end
    end
  end
end
