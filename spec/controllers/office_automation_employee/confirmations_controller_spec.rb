require 'spec_helper'

module OfficeAutomationEmployee
  describe ConfirmationsController do
    devise_mapping
    include_engine_routes

    before(:each)do
      @user = FactoryGirl.create(:admin)
    end

    context "#new" do
      it "renders new template" do
        get :new
        expect(response).to be_success
      end
    end

    context "#create" do
      it "will send confirmation mail to admin" do
        post :create, user: { email: @user.email }
        expect(@user.confirmation_token).not_to be_nil
        expect(response).to be_redirect
      end
    end

    context "#show" do
      it "will confirm admin and change his status to Active" do
        mail_body = @user.send_confirmation_instructions.body.to_s
        get :show, confirmation_token: mail_body[/confirmation_token=([^"]+)/, 1]
        expect(@user.reload.confirmation_token).to eql mail_body[/confirmation_token=([^"]+)/, 1]
        expect(@user.status).to eql("Active")
        expect(response).to be_redirect
      end
    end
  end
end
