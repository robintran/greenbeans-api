class Api::Merchant::TokensController < Api::Merchant::BaseController

  def create 
    @token = current_merchant.tokens.create 
    @token.create_beans(params[:quantity].to_i) if params[:quantity].try(:to_i) > 0
    render json: {status: 200, token: @token.code, quantity: params[:quantity]}
  end

  def beans 
    @token = current_merchant.tokens.find_by_code params[:code]
    if @token 
      hash = {status: 200, token: params[:code], beans: @token.beans.map(&:code)}
    else
      hash = {status: 205, message: "cannot find token with code : #{params[:code]}"}
    end
    render json: hash
  end
end
