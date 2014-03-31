require 'spec_helper'

module OfficeAutomationEmployee
  describe InvitationsController do

    devise_mapping
    include_engine_routes
  
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }

    context 'sending an invitation' do
      before(:each) do
        sign_in admin
        admin.confirm!
      end

      context '#new' do
        it "renders new template" do
          get :new
          expect(response).to render_template(:new)
        end
      end

      context '#create' do
        it "sends invitation to multiple users with valid email address" do

          user_params = { "0" => { email: "user1@domain.com", roles: Role.first.id.to_s, _destroy: 'false' },  "1" => { email: "user2@domain.com", roles: Role.last.id.to_s, _destroy: 'false' } }

          post :create, company: { users_attributes: user_params }
          invitee = User.find_by email: "user1@domain.com"

          expect(User.count).to eq(3)
          expect(invitee.invitation_token).not_to be_nil
          expect(invitee.company).to eq(admin.company)
          expect(invitee.role? 'admin').to eq(true)
          expect(response).to be_redirect
        end

        it "dosen't send invitation to invalid email address" do

          user_params = { "0" => { email: "user1@domain", roles: Role.first.id.to_s, _destroy: 'false' } }
          post :create, company: { users_attributes: user_params }

          expect(User.count).to eq(1)
          expect(response).to render_template(:new)
        end

        it "sends invitation to emails read from csv file and entered in text field" do
          user_params = { "0" => { email: "admin@yahoo.com", roles: Role.first.id.to_s, _destroy: 'false' } }
          csv_file = Rack::Test::UploadedFile.new("#{Engine.root}/spec/list.csv", "text/csv")
          post :create, company: { users_attributes: user_params, csv_file: csv_file }
          invitee = User.find_by email: "hr@gmail.com"

          expect(User.count).to eq(5)
          expect(invitee.role? 'hr').to eq(true)
          expect(response).to be_redirect
        end

        it "dosen't send mail to invalid email address read from csv file" do
          user_params = { "0" => { email: "", roles: Role.first.id.to_s, _destroy: 'false' } }
          csv_file = Rack::Test::UploadedFile.new("#{Engine.root}/spec/invalid_list.csv", "text/csv")
          post :create, company: { users_attributes: user_params, csv_file: csv_file }

          expect(response).to render_template(:new)
        end
      end
    end

    context 'accepting an invitation' do
      context '#edit' do
        it 'renders edit template' do
          mail_body = user.invite!(admin).body.to_s
          get :edit, invitation_token: mail_body[/invitation_token=([^"]+)/, 1]
          expect(user.invitation_token).not_to be_nil
          expect(response).to render_template(:edit)
        end

        it "throws error for invalid invitation token" do
          mail_body = user.invite!(admin).body.to_s
          get :edit, invitation_token: "abcd1234"
          expect(flash[:alert]).to eql "The invitation token provided is not valid!"
        end
      end

      context '#update' do
        it "accepts invitation and changes invitee status to active"  do
          mail_body = user.invite!(admin).body.to_s
          patch :update, user: { invitation_token: mail_body[/invitation_token=([^"]+)/, 1], password: "abcdabcd", password_confirmation: "abcdabcd" }
          expect(user.reload.status).to eql "Active"
          expect(user.invitation_token).to be_nil
          expect(response).to be_redirect
        end
      end
    end
  end
end
