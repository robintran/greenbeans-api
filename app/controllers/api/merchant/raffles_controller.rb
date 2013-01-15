class Api::Merchant::RafflesController < Api::Merchant::BaseController
  def create
    @raffle = current_merchant.raffles.create(params[:raffle])
    if @raffle.errors.blank?
      render json: {status: 200, raffle: @raffle.attributes}
    else
      render json: {status: 205, message: @raffle.errors.full_messages}
    end
  end
end
