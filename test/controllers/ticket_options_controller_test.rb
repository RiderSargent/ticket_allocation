require "test_helper"

class TicketOptionsControllerTest < ActionDispatch::IntegrationTest
  test "/ticket_options/:id returns success" do
    ticket_option = ticket_options(:one)

    get "/ticket_options/#{ticket_option.id}"

    assert_response :success
  end

  test "/ticket_options/:id returns 404 for invalid ticket option id" do
    get "/ticket_options/no-such-ticket-option"

    assert @response.status = 404
  end
end
