require 'spec_helper'

describe Api::Merchant::TokensController do

  let!(:merchant) { FactoryGirl.create(:merchant) }
  
  before do
    sign_in merchant  
  end
  
  describe "Create" do
    it "should return error when user not signed in yet" do
      sign_out merchant
      post :create, format: :json
      response.should_not be_success
      data = JSON.parse(response.body)
      data["error"].should eq("You need to sign in or sign up before continuing.")
    end
    
    it "should not create token without beans_count" do
      post :create, format: :json
      response.should be_success
      data = JSON.parse(response.body)
      data["code"].should eq 205
      data["message"].should eq("Required parameter missing: beans_count")
    end
    
    it "should not create token with non-integer beans_count" do
      post :create, beans_count: "ss", format: :json
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Beans count is not a number")
    end
    
    it "should create token with number of beans less than 1" do
      post :create, beans_count: 0, format: :json
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      assigns[:token].should_not be_nil
      data["message"].should include("Beans count must be greater than 0")
    end
    
    it "should create token with number of beans" do
      post :create, beans_count: 3, format: :json
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(200)
      assigns[:token].should_not be_nil
      assigns[:token].beans.size.should eq 3
    end
    
  end
  
end
