class Api::Merchant::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter  :authenticate_merchant!

  respond_to :json

  rescue_from Exception do |exception|
    output = generate_exception_output(exception)
    render :json => output
  end
end
