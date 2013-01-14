class Api::Consumer::SessionsController < Api::Consumer::BaseController
  skip_before_filter :authenticate_user!, :only => [:create]

  def create
    params[:user] ||= {}
    resource = User.find_for_database_authentication(:email => params[:user][:email])
    if resource && resource.valid_password?(params[:user][:password])
      sign_in(:user, resource)
    end
    hash = {}
    if current_user 
      current_user.reset_authentication_token!
      hash = {
              status: 200,
              user: current_user.attributes.merge(auth_token: current_user.authentication_token).
                except('encrypted_password', 'reset_password_token'),
              message: "Sign in successfully."
      }
    else
      hash = {status: 205, user: {email: params[:user][:email]}, business: {}, message: "Invalid email or password."}
    end
    render :json => hash
  end

  def delete
    current_userreset_authentication_token!
    hash = {}
    if current_user.reload.authentication_token != params[:auth_token]
      sign_out(:user)
      hash[:status] = 200
      hash[:message] = "Destroy session successfully."
    else
      hash[:status] = 205
      hash[:message] = "Not authorize."
    end
    render :json => hash
  end  
end
