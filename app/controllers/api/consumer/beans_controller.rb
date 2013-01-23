class Api::Consumer::BeansController < Api::Consumer::BaseController
  skip_before_filter :authenticate_user!, :only  => [:validate]

  def my_beans
    @active_beans = current_user.beans.actives.map(&:code)
    @redeemed_beans = current_user.beans.redeemeds.map(&:code)
    @on_raffle_beans = current_user.beans.on_raffles.map(&:code)
    if current_user.beans.any?
      render json: { status: 200, actives: @active_beans, redeemeds: @redeemed_beans, on_raffles: @on_raffle_beans }
    else
      render json: { status: 205, message: "You currently have no beans"}
    end
  end
  
  def validate
    validate_params "code"
    bean = Bean.find_by_code params[:code]

    if bean
      if bean.redeemed
        render json: {status: 205, valid: false, message: "#{bean.code} is redeemed"}
      elsif bean.used_on == Bean::USED_ON[:none]
        render json: {status: 200, valid: true, message: "#{bean.code} is valid"}
      else
        render json: {status: 205, valid: false, message: "#{bean.code} is invalid, bean had been used on #{bean.used_on}"}
      end
    else
      render json: {status: 205, valid: false, message: "bean code #{params[:code]} not found"}
    end
  end
end

