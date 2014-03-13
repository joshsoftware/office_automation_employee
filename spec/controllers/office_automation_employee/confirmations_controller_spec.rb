require 'spec_helper'

module OfficeAutomationEmployee
  describe ConfirmationsController do
    devise_mapping
    include_engine_routes

    let(:admin) { create(:admin) }

    context "#new" do
      it "renders new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "#create" do
      it "sends confirmation mail to admin" do
        post :create, user: { email: admin.email }

        expect(admin.confirmation_token).not_to be_nil
        expect(response).to be_redirect
      end
    end

    context "#show" do
      it "confirms admin and changes his status to Active" do
        mail_body = admin.send_confirmation_instructions.body.to_s
        get :show, confirmation_token: mail_body[/confirmation_token=([^"]+)/, 1]

        expect(admin.reload.confirmation_token).to eql mail_body[/confirmation_token=([^"]+)/, 1]
        expect(admin.status).to eql("Active")
        expect(response).to be_redirect
      end
    end
  end
end
