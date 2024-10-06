require "test_helper"

class TicketOptionsControllerTest < ActionDispatch::IntegrationTest
  # Get Ticket Option - GET /ticket_options/:id
  test "/ticket_options/:id returns success" do
    ticket_option = ticket_options(:one)

    get "/ticket_options/#{ticket_option.id}"

    assert_response :success
  end

  test "/ticket_options/:id returns 404 for invalid ticket option id" do
    get "/ticket_options/no-such-ticket-option"

    assert @response.status = 404
  end

  # Create Ticket Option - POST /ticket_options
  test "/ticket_options creates a new ticket option" do
    params = {
      name: "Test ticket option",
      desc: "ticket option description",
      allocation: 100
    }

    assert_difference('TicketOption.count', 1) do
      post "/ticket_options", params: params
    end

    assert_response :success
  end
end
