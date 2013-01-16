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
    
    it "should not create token without quantity" do
      post :create, format: :json
      response.should be_success
      data = JSON.parse(response.body)
    end
  end
  
end
