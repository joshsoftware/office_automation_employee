require 'spec_helper'

module OfficeAutomationEmployee
  describe RegistrationsController do
    devise_mapping
    include_engine_routes

    context "#new" do
      it "renders new template" do
        get :new
        expect(response).to be_success
      end
    end

    context "#create" do
      it "will register a company and creates an admin for that company" do
        post :create, user: { email: "admin@josh.com", password: "abcdabcd", password_confirmation: "abcdabcd", 
          company: { name: "josh software",
            current_address: { address: "thube park", city: "pune", state: "maharashtra", country: "india", 
              pincode: "411005", phone: 0202342323 } } }
        expect(response).to be_redirect
      end
    end
  end
end
