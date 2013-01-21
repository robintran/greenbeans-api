require 'spec_helper'

describe Api::Consumer::RegistrationsController do
  describe "create" do
    before do 
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end
    
    it "should register new user" do
      user = {email: Faker::Internet.email, password: '12345678'}
      post :create, format: :json, user: user
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq 200
      assigns[:user].should_not be_nil
      assigns[:user].email.should eq user[:email]
    end
    
    it "should fail when email is blank" do
      user = {password: '12345678'}
      post :create, format: :json, user: user
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 205
      data['message'].should include "Email can't be blank"
    end
    
    it "should fail when password is blank" do
      user = {email: Faker::Internet.email}
      post :create, format: :json, user: user
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 205
      data['message'].should include "Password can't be blank"
    end
    
    it "should fail when password lenght is less than 8 letters" do
      user = {email: Faker::Internet.email, password: '1234567'}
      post :create, format: :json, user: user
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 205
      data['message'].should include "Password is too short (minimum is 8 characters)"
    end
    
    it "should fail when email has already been taken" do
      user = FactoryGirl.create(:user)
      user = {email: user.email, password: '12345678'}
      post :create, format: :json, user: user
      response.should be_success
      data = JSON.parse(response.body)
      data['status'].should eq 205
      data['message'].should include "Email has already been taken"
    end
    
  end
end
