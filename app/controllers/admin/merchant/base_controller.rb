class Admin::Merchant::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter  :authenticate_merchant!

  layout "admin"
end
