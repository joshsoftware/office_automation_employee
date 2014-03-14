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

      it "Registers a new company, creates new user with role admin and assigns roles to company" do

        post :create, company: { name: "josh software", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "maharashtra", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: false, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   

        expect(Company.count).to eq(1)

        expect(User.find_by(email: 'abc@abc.com').role.include?('Admin')).to eq(true)

        expect(User.count).to eq(1)

        expect(Company.last.roles.count).to eq(Role.count)

        expect(response).to be_redirect
      end

      it 'Checks if same_as_registered_address field is true then current address is same as registered address' do

        post :create, company: { name: "josh software", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "mh", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   

        registered_address = Company.find_by(name: "josh software").registered_address
        current_address = Company.find_by(name: "josh software").current_address

        expect(registered_address.address).to eq(current_address.address)
        expect(registered_address.city).to eq(current_address.city)

        expect(registered_address.state).to eq(current_address.state)
        expect(registered_address.country).to eq(current_address.country)

        expect(registered_address.phone).to eq(current_address.phone)
        expect(registered_address.pincode).to eq(current_address.pincode)
      end

      it "Does not create company if company with same name is aldready exist" do

        post :create, company: { name: "josh software", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "mh", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   


        post :create, company: { name: "josh software", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "mh", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   
        
        expect(Company.count).to eq(1)
        expect(User.count).to eq(1)

      end

      it "Does not create user if user with same email-id exist" do

        post :create, company: { name: "josh software", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "mh", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   
        
        post :create, company: { name: "josh software private limited", registration_date: '2011/11/11', current_address: { address: "thube park", city: "pune", state: "mh", country: "india", pincode: "411005", phone: 0202342323 },registered_address: {address: 'Pune', city: 'Pune', state: 'MH', country: 'India', pincode: '12345', phone: '0202342323'},same_as_registered_address: true, users_attributes: {"0" => {email: "abc@abc.com", password: "abcdabcd", password_confirmation: "abcdabcd"}}}   

        expect(Company.count).to eq(1)
        expect(User.count).to eq(1)
      end

    end
  end
end
