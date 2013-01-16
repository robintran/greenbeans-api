class Api::Merchant::TokensController < Api::Merchant::BaseController

  def create 
    validate_params "beans_count"
    @token = current_merchant.tokens.create(beans_count: params[:beans_count]) 
    #@token.create_beans(params[:quantity].to_i) if params[:quantity].try(:to_i) > 0
    if @token.errors.blank?
      render json: {status: 200, token: @token.code, beans: params[:beans_count]}
    else
      render json: {status: 205, message: @token.errors.full_messages}
    end
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
