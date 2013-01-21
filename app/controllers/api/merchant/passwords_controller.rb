class Api::Merchant::PasswordsController < Devise::PasswordsController

  def create
    respond_to do |format|  
      format.html { 
        super 
      }
      format.json {
        validate_resource_params('merchant', 'email')
        self.resource = resource_class.send_reset_password_instructions(resource_params)
        if successfully_sent?(resource)
          render :json => {status: 200, message: "Password reset instructions email has been sent."}
        else
          render :json => {status: 205, message: "Email not exist"}
        end
      }
    end
  end
  
  rescue_from Exception do |exception|
    output = generate_exception_output(exception)
    render :json => output
  end
  
end
