require 'spec_helper'

module OfficeAutomationEmployee
  describe ConfirmationsController do
    devise_mapping
    include_engine_routes

    context "#new" do
      it "renders new template" do
        get :new
        expect(response).to be_success
      end
    end

    context "#create" do
      it "will send confirmation mail to admin" do
        FactoryGirl.create(:admin)
        post :create, user: { email: "admin@gmail.com" }
        expect(response).to be_redirect
      end
    end
  end
end
