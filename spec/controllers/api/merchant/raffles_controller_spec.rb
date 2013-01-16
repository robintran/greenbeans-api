require 'spec_helper'

describe Api::Merchant::RafflesController do
  render_views
  
  let!(:merchant) { FactoryGirl.create(:merchant) }
  
  before do
    sign_in merchant  
  end
  describe "Create" do
    
    it "should create raffle" do
      post :create, raffle: {name: "Test Raffle", num_of_winner: 3}
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(200)
      data["raffle"]["name"].should eq("Test Raffle")
    end
    
    it "should return error when user not signed in yet" do
      sign_out merchant
      post :create, format: :json
      response.should_not be_success
      data = JSON.parse(response.body)
      data["error"].should eq("You need to sign in or sign up before continuing.")
    end
    
    it "should not create raffle when missing name" do
      post :create, raffle: {num_of_winner: 3}
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Name can't be blank")
    end
    
    it "should not create raffle when missing num of winner" do
      post :create, raffle: {name: "Test Raffle"}
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Num of winner can't be blank")
    end
    
  end
  
  describe "Delete" do
    it "should delete raffle" do
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      delete :destroy, id: raffle.id
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(200)
      data["message"].should eq("deleted raffle successfully.")
    end
    
    it "should return error when user not signed in yet" do
      sign_out merchant
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      delete :destroy, id: raffle.id, format: :json
      response.should_not be_success
      data = JSON.parse(response.body)
      data["error"].should eq("You need to sign in or sign up before continuing.")
    end
    
    it "should return error when input wrong id" do
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      delete :destroy, id: -1, format: :json
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("coundn't found raffle with id -1.")
    end
    
  end
end
