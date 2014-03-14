require 'spec_helper'

module OfficeAutomationEmployee
  describe PasswordsController do
    
    devise_mapping
    include_engine_routes

    let(:user) { create(:user) }

    context "#new" do
      it "renders new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "#create" do
      it "sends reset password instructions" do
        post :create, user: { email: user.email }

        expect(user.reload.reset_password_sent_at).not_to be_nil
        expect(user.reset_password_token).not_to be_nil
        expect(response).to be_redirect
      end
    end

    context "#edit" do
      it "renders edit template" do
        get :edit, reset_password_token: user.send_reset_password_instructions
        expect(response).to render_template(:edit)
      end
    end

    context "#update" do
      it "updates user password" do
        patch :update, user: { reset_password_token: user.send_reset_password_instructions, password: "abcdabcd", password_confirmation: "abcdabcd" }

        expect(user.reload.reset_password_token).not_to be_nil
        expect(response).to be_redirect
      end
    end
  end
end
