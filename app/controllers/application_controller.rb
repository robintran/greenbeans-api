class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def validate_params(*args)
    args.each { |name|
      if params[name].blank?
        raise Exceptions::ApiException.new(
          :major_code => 205,
          :sub1 => name
        ), 'Required parameter missing: ' + name
      end
    }
  end
  
  def validate_resource_params(resource, *args)
    res = params[resource] || {}
    args.each { |name|
      if res[name].blank?
        raise Exceptions::ApiException.new(
          :major_code => 205,
          :sub1 => name
        ), "Required parameter missing: #{resource} #{name}"
      end
    }
  end
  
  def generate_exception_output(exception)
    output = {
      'message'     => exception.message,
      'code'        => exception.respond_to?("code") ? exception.code : 500,
      'diagnostic1' => exception.respond_to?("diagnostic1") ? exception.diagnostic1.to_s : exception.to_s,
      'diagnostic2' => exception.respond_to?("diagnostic2") ? exception.diagnostic2.to_s : nil,
      'trace'       => Rails.env.development? ? exception.backtrace : "Disabled at this time"
    }
  end
  
end
