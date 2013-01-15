class Api::Merchant::BeansController < Api::Merchant::BaseController

  def validate
    render json: {valid: false, message: "param code cannot be blank"} and return if params[:code].blank?
    bean = Bean.find_by_code params[:code]

    if bean
      if bean.used_on == Bean::USED_ON[:none]
        render json: {valid: true, message: "#{bean.code} is valid"}
      else
        render json: {valid: false, message: "#{bean.code} is invalid, used on #{bean.used_on}"}
      end
    else
      render json: {valid: false, message: "#{params[:code]} not found"}
    end
  end
end

