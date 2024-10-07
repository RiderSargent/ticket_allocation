class PurchasesController < ApplicationController
  def create
    @ticket_option = TicketOption.find(params[:ticket_option_id])

    if @ticket_option.allocation >= purchase_params[:quantity].to_i
      @purchase = Purchase.new(purchase_params)
      @purchase.ticket_option = @ticket_option
      @purchase.save!

      render json: { status: :ok }
    else
      render json: { error: "Not enough allocation" }, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.permit(:quantity, :user_id)
  end
end
