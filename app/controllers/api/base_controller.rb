class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token

  respond_to :json

  rescue_from Exception do |exception|
    render :json => {status: 500, auth: false, message: exception.message}
  end  
end
