class TicketOptionsController < ApplicationController
  def show
    @ticket_option = TicketOption.find(params[:id]).slice(:id, :name, :desc, :allocation)

    render json: @ticket_option
  end
end
