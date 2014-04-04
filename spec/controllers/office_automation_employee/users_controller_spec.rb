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
      user.update_attribute :company, admin.company
      user.accept_invitation!
      user.update_attribute :status, "Active"
      sign_in user
    end

    context '#index' do
      it 'Renders index template' do
        get :index, company_id: user.company
        expect(response).to render_template(:index)
      end

      it 'searches in database and then renders index template' do
        get :index, company_id: user.company, q: 'com'
        expect(assigns(:users).count).to eq(2)
        expect(response).to render_template(:index)
      end

      it 'count will be zero if search fails' do

        get :index, company_id: user.company, q: 'abcd'
        expect(assigns(:users).count).to eq(0)
        expect(response).to render_template(:index)
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
        xhr :put, :update, user: {profile_attributes: {first_name: 'abcd', last_name: 'abc', mobile_number: 1234567890, upload: @file}}, company_id: user.company, id:user

        expect(user.reload.profile.first_name).to eq('abcd')
        expect(user.profile.last_name).to eq('abc')
        expect(user.profile.mobile_number).to eq(1234567890)
        expect(response).to be_success
      end

      it 'Will not update profile if mandatory field is empty' do

        xhr :put, :update, user: {profile_attributes: {last_name: 'abc', mobile_number: 1234567890}}, company_id: user.company, id:user

        expect(response).to render_template(:update)
      end

      it 'Updates personal profile' do
        xhr :put, :update, user: { personal_profile_attributes:{same_as_permanent_address: true, permanent_address: {address: 'shivajinagar', city: 'pune', pincode: 12345, state: 'MH', country: 'India', phone: 1234567890}}}, company_id: user.company, id: user

        expect(user.reload.personal_profile.permanent_address.address).to eq('shivajinagar')
        expect(user.personal_profile.permanent_address.city).to eq('pune')
        expect(user.personal_profile.permanent_address.pincode).to eq(12345)
        expect(user.personal_profile.permanent_address.state).to eq('MH')
        expect(user.personal_profile.permanent_address.phone).to eq(1234567890)
        expect(user.personal_profile.permanent_address.country).to eq('India')

      end

      it 'Will not save current address if same_as_permanent_address is true' do
        xhr :put, :update, user: { personal_profile_attributes:{same_as_permanent_address: true, permanent_address: {address: 'shivajinagar', city: 'pune', pincode: 12345, state: 'MH', country: 'India', phone: 1234567890}}}, company_id: user.company, id: user

        expect(user.reload.personal_profile.current_address).to eq(nil)
      end

      it 'Uploads documents' do

        @f = Rack::Test::UploadedFile.new("#{Engine.root}/spec/neukirchen07introducingrack.pdf", "text/pdf")
        xhr :put, :update, user: { attachments_attributes: { "0" => { document: @f , _destroy: "false"} } }, company_id: user.company, id: user
        expect(user.reload.attachments.count).to eq(1)

      end

      it 'Will not upload document if document size is greater than 10 MB' do

        @f = Rack::Test::UploadedFile.new("#{Engine.root}/spec/Head First jQuery.pdf", "text/pdf")

        xhr :put, :update, user: { attachments_attributes: { "0" => {document: @f, _destroy: "false"} } }, company_id: user.company, id: user

        expect(user.reload.attachments.count).to eq(0)
      end

    end

    context '#destroy' do
      it 'removes user from company' do
        sign_out user
        sign_in admin
        delete :destroy, company_id: user.company, id: user
        expect(User.count).to eq(2)
        expect(response).to redirect_to company_users_path
      end
    end

    context '#resend_invitation' do
      it 'resends invitation to user' do
        sign_out user
        sign_in admin
        get :resend_invitation, company_id: user.company, id: user
        expect(user.reload.invitation_token).not_to be_nil
        expect(response).to redirect_to company_user_path
      end
    end

    context '#activation_status' do
      it 'change activation status of user' do
        sign_out user
        sign_in admin
        get :activation_status, company_id: user.company, id: user
        expect(user.reload.status).to eql "Deactive"
        expect(response).to redirect_to company_user_path
      end
    end
  end
end
