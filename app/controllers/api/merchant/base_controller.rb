class Api::Merchant::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter  :authenticate_merchant!, :set_headers
  
  respond_to :json

  before_filter :set_headers

  private

  def set_headers
    if request.headers["HTTP_ORIGIN"] #&& /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
      headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
      headers['Access-Control-Max-Age'] = '86400'
      headers['Access-Control-Allow-Credentials'] = 'true'
    end
  end
  
  rescue_from Exception do |exception|
    output = generate_exception_output(exception)
    render :json => output
  end
end
