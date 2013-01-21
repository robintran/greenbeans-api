require 'spec_helper'

describe Api::Merchant::RegistrationsController do
  
  describe "create" do
    before do 
      @request.env["devise.mapping"] = Devise.mappings[:merchant]
    end
    
    it "should register new merchant" do
      merchant = {name: Faker::Name.name, email: Faker::Internet.email, password: '12345678'}
      post :create, format: :json, merchant: merchant
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 200
      assigns[:merchant].should_not be_nil
      assigns[:merchant].email.should eq merchant[:email]
      assigns[:merchant].tokens.size.should eq 1
    end
    
    it "should fail when name is blank" do
      merchant = {email: Faker::Internet.email, password: '12345678'}
      post :create, format: :json, merchant: merchant
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 205
      data['message'].should include "Name can't be blank"
    end
    
    it "should fail when email is blank" do
      merchant = {name: Faker::Name.name, password: '12345678'}
      post :create, format: :json, merchant: merchant
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 205
      data['message'].should include "Email can't be blank"
    end
    
    it "should fail when password is blank" do
      merchant = {name: Faker::Name.name, email: Faker::Internet.email}
      post :create, format: :json, merchant: merchant
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 205
      data['message'].should include "Password can't be blank"
    end
    
    it "should fail when password lenght is less than 8 letters" do
      merchant = {name: Faker::Name.name, email: Faker::Internet.email, password: '1234567'}
      post :create, format: :json, merchant: merchant
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 205
      data['message'].should include "Password is too short (minimum is 8 characters)"
    end
    
    it "should fail when email has already been taken" do
      merchant = FactoryGirl.create(:merchant)
      merchant = {name: Faker::Name.name, email: merchant.email, password: '12345678'}
      post :create, format: :json, merchant: merchant
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 205
      data['message'].should include "Email has already been taken"
    end
    
    it "should fail when name has already been taken" do
      merchant = FactoryGirl.create(:merchant)
      merchant = {name: merchant.name, email: Faker::Internet.email, password: '12345678'}
      post :create, format: :json, merchant: merchant
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq 205
      data['message'].should include "Name has already been taken"
    end
    
  end
end
