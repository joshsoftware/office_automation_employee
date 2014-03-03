require 'spec_helper'

module OfficeAutomationEmployee
  describe PasswordsController do
    
    devise_mapping
    include_engine_routes

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    context "#new" do
      it "renders new template" do
        get :new
        expect(response).to be_success
      end
    end

    context "#create" do
      it "will send reset password instructions" do
        post :create, user: { email: @user.email }
        expect(@user.reload.reset_password_sent_at).not_to be_nil
        expect(response).to be_redirect
      end
    end

    context "#edit" do
      it "renders edit template" do
        get :edit, reset_password_token: @user.send_reset_password_instructions
        expect(response).to be_success
      end
    end

    context "#update" do
      it "updates user password" do
        patch :update, user: { reset_password_token: @user.send_reset_password_instructions, password: "abcdabcd", password_confirmation: "abcdabcd" }
        expect(@user.reload.reset_password_sent_at).to be_nil
        expect(response).to be_redirect
      end
    end
  end
end
