require 'spec_helper'

module OfficeAutomationEmployee
  describe CompaniesController do
    include_engine_routes

    let(:super_admin) { User.find('superadmin') }
    let(:admin) { create(:admin) }
    
    context "#index" do
      it "renders index template" do
        sign_in super_admin
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "#edit" do
     it "renders edit template"  do
       admin.confirm!
       sign_in admin
       get :edit, id: admin.company
       expect(response).to render_template(:edit)
     end
    end

    context "#update" do
      it "updates company details" do
        admin.confirm!
        sign_in admin
        put :update, id: admin.company, company: { name: "josh pvt ltd" }
        expect(admin.company.reload.name).to eql("josh pvt ltd")
        expect(flash[:success]).to eql("Profile updated successfully.")
      end

      it "fails update if some field is missing" do
        admin.confirm!
        sign_in admin
        put :update, id: admin.company, company: { name: nil }
        expect(flash[:danger]).to eql("Please fill the fields accordingly.")
        expect(response).to render_template(:edit)
      end
    end

    context "#show" do
      it "renders show template" do
        admin.confirm!
        sign_in admin
        get :show, id: admin.company
       expect(response).to render_template(:show)
      end
    end

    context "#destroy" do
      it "destroys company if user is super admin" do
        sign_in super_admin
        delete :destroy, id: admin.company
        expect(Company.count).to eql 0
      end

      it "fails if user is admin of that company" do
        admin.confirm!
        sign_in admin
        delete :destroy, id: admin.company
        expect(flash[:danger]).to eql("You are not allowed to perform this action.")
      end
    end
  end
end
