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

      it "will register a company, create user with role admin and assign roles to company" do

        post :create, user: { email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd", company_attributes: { name: "josh software",current_address: { address: "thube park", city: "pune", state: "maharashtra", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: false}}   

        expect(Company.count).to eq(1)

        expect(User.find_by(email: 'abc@abc.com').role.include?('Admin')).to eq(true)

        expect(User.count).to eq(1)

        expect(Company.last.roles.count).to eq(Role.count)

        expect(response).to be_redirect
      end
      
      it 'will check if same_as_registered_address is true then current address is same as registered address' do

        post :create, user: { email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd", company_attributes: { name: "josh software",current_address: { address: "pune", city: "pune", state: "MH", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true}}   


        registered_address = Company.find_by(name: "josh software").registered_address
        current_address = Company.find_by(name: "josh software").current_address
        
        expect(registered_address.address).to eq(current_address.address)
        expect(registered_address.city).to eq(current_address.city)

        expect(registered_address.state).to eq(current_address.state)
        expect(registered_address.country).to eq(current_address.country)
        
        expect(registered_address.phone).to eq(current_address.phone)
        expect(registered_address.pincode).to eq(current_address.pincode)
      end

      it "will not create company if company with same name is aldready exist" do
      
      Company.create(name: "josh software")

      post :create, user: { email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd", company_attributes: { name: "josh software",current_address: { address: "pune", city: "pune", state: "MH", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_flag: true}}   
      
      expect(Company.count).to eq(1)
      expect(User.count).to eq(0)

      end

      it "will not create user if user with same email-id exist" do

        post :create, user: { email: 'abc@abc.com', password: "abcdabcd", password_confirmation: "abcdabcd", company_attributes: { name: "josh software",current_address: { address: "pune", city: "pune", state: "MH", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true}}   
        post :create, user: { email: 'abc@abc.com', password: "abcdabcd", password_confirmation: "abcdabcd", company_attributes: { name: "josh software",current_address: { address: "pune", city: "pune", state: "MH", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true}}   

        expect(Company.count).to eq(1)
        expect(User.count).to eq(1)
      end

    end
  end
end
