require 'spec_helper'

module OfficeAutomationEmployee
  describe RegistrationsController do
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

      it "Registers a new company, creates new user with role admin and assigns roles to company" do

        post :create, company: { name: "josh software", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "maharashtra", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: false, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   


        expect(Company.count).to eq(1)

        expect(User.find_by(email: 'abc@abc.com').role?('Admin')).to eq(true)

        expect(User.count).to eq(2)

        expect(Company.last.roles.count).to eq(Role.count)

        expect(response).to be_redirect
      end

      it "Will not Register a new company, if mandatory field is empty" do

        post :create, company: { registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "maharashtra", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: false, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   

        expect(Company.count).to eq(0)

        expect(User.count).to eq(1)

        expect(response).to render_template(:new)
      end
      it 'Checks if same_as_registered_address field is true then current address will not get saved' do

        post :create, company: { name: "josh software", registration_date: '2011/11/11', registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   

        registered_address = Company.find_by(name: "josh software").registered_address
        current_address = Company.find_by(name: "josh software").current_address

        expect(current_address).to eq(nil)
      end

      it "Does not create company if company with same name is aldready exist" do

        post :create, company: { name: "josh software", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "mh", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   


        post :create, company: { name: "josh software", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "mh", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   
        
        expect(Company.count).to eq(1)
        expect(User.count).to eq(2)

      end

      it "Does not create user if user with same email-id exist" do

        post :create, company: { name: "josh software", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "mh", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   
        
        post :create, company: { name: "josh software private limited", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "mh", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   

        expect(Company.count).to eq(1)
        expect(User.count).to eq(2)
      end
    end

    context "#update" do
      it "updates user password" do
        admin.confirm!
        sign_in admin
        put :update, user: { password: 'abcdabcd', password_confirmation: 'abcdabcd', current_password: "12345678" }, id: admin
        expect(flash[:success]).to eql "Password Updated Successfully."
        expect(response).to be_redirect
      end

      it "fails if current password is invalid" do
        admin.confirm!
        sign_in admin
        put :update, user: { password: 'abcdabcd', password_confirmation: 'abcdabcd', current_password: "abcdabcd" }, id: admin
        expect(flash[:danger]).to eql "Please fill the fields accordingly."
        expect(response).to render_template(:edit)
      end

    end
  end
end
