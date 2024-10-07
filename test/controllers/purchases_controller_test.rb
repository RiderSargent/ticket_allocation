require "test_helper"

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  def create_ticket_option
    TicketOption.create!(
      name: "Test ticket option",
      desc: "ticket option description",
      allocation: 100
    )
  end

  # Purchase tickets - POST /ticket_options/:id/purchases
  test "creates a new purchase" do
    ticket_option = create_ticket_option

    params = {
      quantity: 1,
      user_id: "d6abe829-c28c-44ec-bee6-3183f2c53fef"
    }

    assert_difference("Purchase.count", 1) do
      post "/ticket_options/#{ticket_option.id}/purchases", params: params
    end

    created_purchase = Purchase.last

    assert_response :success

    assert_equal 1, created_purchase.quantity
    assert_equal "d6abe829-c28c-44ec-bee6-3183f2c53fef", created_purchase.user_id
    assert_equal ticket_option.id, created_purchase.ticket_option_id
  end

  test "does not create purchase if quantity is more than available" do
    ticket_option = create_ticket_option

    params = {
      quantity: 101,
      user_id: "d6abe829-c28c-44ec-bee6-3183f2c53fef"
    }

    assert_no_difference("Purchase.count") do
      post "/ticket_options/#{ticket_option.id}/purchases", params: params
    end

    assert_response :unprocessable_entity
  end
end
