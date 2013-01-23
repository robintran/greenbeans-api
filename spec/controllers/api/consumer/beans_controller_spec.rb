require 'spec_helper'

describe Api::Consumer::BeansController do
  
  let!(:merchant) { FactoryGirl.create(:merchant) }
  let!(:user) { FactoryGirl.create(:user) }
  
  before do
    sign_in user
  end
  
  describe "GET beans" do
    it "should show message when there is no beans for current consumer" do
      get :my_beans
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq 205
      data["message"].should eq "You currently have no beans"
    end
    
    it "should return consumer beans code arrays" do
      token = FactoryGirl.create(:token, merchant: merchant)
      beans = token.beans
      beans.each_with_index do |bean,i|
        bean.used_on = i < 3 ? 'none' : (i < 5 ? 'raffle' : 'gift')
        bean.user_id = user.id
        bean.save
      end
      beans.last.update_attribute(:redeemed, true)
      get :my_beans
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq 200
      data["actives"].size.should eq 3
      data["on_raffles"].size.should eq 2
      data["redeemeds"].size.should eq 1
    end
    
    it "should not success if user not signed in" do
      sign_out user
      get :my_beans
      response.should_not be_success
    end
    
  end
end
