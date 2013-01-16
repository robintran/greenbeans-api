class Api::Merchant::RafflesController < Api::Merchant::BaseController
  def create
    @raffle = current_merchant.raffles.create(params[:raffle])
    if @raffle.errors.blank?
      render json: {status: 200, raffle: @raffle.attributes}
    else
      render json: {status: 205, message: @raffle.errors.full_messages}
    end
  end
  
  def destroy
    @raffle = Raffle.where(id: params[:id]).first
    if @raffle
      @raffle.destroy
      render json: {status: 200, message: "deleted raffle successfully."}
    else
      render json: {status: 205, message: "coundn't found raffle with id #{params[:id]}."}
    end
  end
  
end
