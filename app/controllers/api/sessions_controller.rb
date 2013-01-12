class Api::SessionsController < Api::BaseController
  skip_before_filter :authenticate_merchant!, :only => [:create]

  def create
    params[:merchant] ||= {}
    resource = Merchant.find_for_database_authentication(:email => params[:merchant][:email])
    if resource && resource.valid_password?(params[:merchant][:password])
      sign_in(:merchant, resource)
    end
    hash = {}
    if current_merchant 
      current_merchant.reset_authentication_token!
      hash = {
              status: 200,
              merchant: current_merchant.attributes.merge(auth_token: current_merchant.authentication_token).
                except('encrypted_password', 'reset_password_token'),
              message: "Sign in successfully."
      }
    else
      hash = {status: 205, merchant: {email: params[:merchant][:email]}, business: {}, message: "Invalid email or password."}
    end
    render :json => hash
  end

  def delete
    current_merchant.reset_authentication_token!
    hash = {}
    if current_merchant.reload.authentication_token != params[:auth_token]
      sign_out(:merchant)
      hash[:status] = 200
      hash[:message] = "Destroy session successfully."
    else
      hash[:status] = 205
      hash[:message] = "Not authorize."
    end
    render :json => hash
  end  
end
