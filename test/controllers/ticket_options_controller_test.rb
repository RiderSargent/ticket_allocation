require "test_helper"

class TicketOptionsControllerTest < ActionDispatch::IntegrationTest
  test "show action success" do
    ticket_option = ticket_options(:one)

    get "/ticket_options/#{ticket_option.id}"

    assert_response :success
  end

  test "fails with invalid ticket option id" do
    get "/ticket_options/no-such-ticket-option"

    assert @response.status = 404
  end
end
