class TicketOptionsController < ApplicationController
  skip_forgery_protection

  def show
    @ticket_option = TicketOption.find(params[:id])

    render json: public_attributes(@ticket_option)
  end

  def create
    @ticket_option = TicketOption.create!(ticket_option_params)

    render json: public_attributes(@ticket_option)
  end

  private

  def ticket_option_params
    params.permit(:name, :desc, :allocation)
  end

  def public_attributes(ticket_option)
    ticket_option.slice(:id, :name, :desc, :allocation)
  end
end
