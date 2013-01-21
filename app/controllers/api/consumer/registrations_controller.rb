class Api::Consumer::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_merchant!
  respond_to :json
  
  def create
    respond_to do |format|  
      format.html { 
        super 
      }
      format.json {
        build_resource
        if resource.save
          render :json => {status: 200, consumer: resource}
        else
          render :json => {status: 205, message: resource.errors.full_messages}
        end
      }
    end
  end
  
  rescue_from Exception do |exception|
    output = generate_exception_output(exception)
    render :json => output
  end
end
