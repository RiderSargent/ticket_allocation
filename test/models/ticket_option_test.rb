require "test_helper"

class TicketOptionTest < ActiveSupport::TestCase
  def create_ticket_option
    TicketOption.create(
      name: "Test ticket option",
      desc: "ticket option description",
      allocation: 100
    )
  end

  test "#available? returns true if remaining allocation >= requested" do
    ticket_option = create_ticket_option

    purchase_params = { quantity: 1 }

    assert ticket_option.available?(purchase_params)
  end

  test "#available? returns false if remaining allocation < requested" do
    ticket_option = create_ticket_option

    purchase_params = { quantity: 101 }

    assert_not ticket_option.available?(purchase_params)
  end

  test "#create_purchase creates a new purchase" do
    ticket_option = create_ticket_option

    purchase_params = {
      quantity: 1,
      user_id: "d6abe829-c28c-44ec-bee6-3183f2c53fef"
    }

    purchase = ticket_option.create_purchase(purchase_params)

    assert purchase.persisted?
    assert_equal 1, purchase.quantity
    assert_equal "d6abe829-c28c-44ec-bee6-3183f2c53fef", purchase.user_id
    assert_equal ticket_option.id, purchase.ticket_option_id
  end

  test "#create_purchase decrements allocation" do
    ticket_option = create_ticket_option

    purchase_params = {
      quantity: 1,
      user_id: "d6abe829-c28c-44ec-bee6-3183f2c53fef"
    }

    ticket_option.create_purchase(purchase_params)

    assert_equal 99, ticket_option.allocation
  end

  test "#create_purchase does not create purchase if quantity is more than available" do
    ticket_option = create_ticket_option

    purchase_params = {
      quantity: 101,
      user_id: "d6abe829-c28c-44ec-bee6-3183f2c53fef"
    }

    purchase = ticket_option.create_purchase(purchase_params)

    assert_nil purchase
  end
end
