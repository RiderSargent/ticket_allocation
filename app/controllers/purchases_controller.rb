class PurchasesController < ApplicationController
  def create
    ticket_option = TicketOption.find(params[:ticket_option_id])

    if ticket_option.create_purchase(purchase_params)
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
