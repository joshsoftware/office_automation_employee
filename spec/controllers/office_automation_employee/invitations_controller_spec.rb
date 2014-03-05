require 'spec_helper'

module OfficeAutomationEmployee
  describe InvitationsController do

    devise_mapping
    include_engine_routes

    context 'sending an invitation' do
      before(:each) do
        @admin = FactoryGirl.create(:admin)
        @user = FactoryGirl.create(:user)
        sign_in @admin
        @admin.confirm!
      end

      context '#new' do
        it "will render new template" do
          get :new
          expect(response).to be_success
        end
      end

      context '#create' do
        it "will send invitation to multiple users with valid email" do
          post :create, user: { email: "user1@domain.com, user2@domain.com" }
          user = User.find_by email: 'user1@domain.com'

          expect(user.invitation_token).not_to be_nil
          expect(response).to be_redirect
        end

        it "won't send mail to invalid email address" do
          post :create, user: { email: "a@a, a," }
          expect(assigns(:invalid_email).count).to eq(2)
          expect(response).not_to be_redirect
        end
      end
    end

    context 'accepting an invitation' do
      before(:each) do
        @admin = FactoryGirl.create(:admin)
        @user = FactoryGirl.create(:user)
      end

      context '#edit' do
        it 'will render edit template' do
          mail_body = @user.invite!(@admin).body.to_s
          get :edit, invitation_token: mail_body[/invitation_token=([^"]+)/, 1]
          expect(@user.invitation_token).not_to be_nil
          expect(response).to be_success
        end
      end

      context '#update' do
        it "will accept invitation and change invitee status to active"  do
          mail_body = @user.invite!(@admin).body.to_s
          patch :update, user: { invitation_token: mail_body[/invitation_token=([^"]+)/, 1], password: "abcdabcd", password_confirmation: "abcdabcd" }
          expect(@user.reload.status).to eql "Active"
          expect(@user.invitation_token).to be_nil
          expect(response).to be_redirect
        end

        it "will throw error for invalid invitation token" do
          mail_body = @user.invite!(@admin).body.to_s
          patch :update, user: { invitation_token: "abcd12", password: "abcdabcd", password_confirmation: "abcdabcd" }
          expect(@user.invitation_token).not_to be_nil
        end
      end
    end
  end
end
