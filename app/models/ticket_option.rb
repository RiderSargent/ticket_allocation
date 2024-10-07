class TicketOption < ApplicationRecord
  has_many :purchases

  validates :allocation, numericality: { greater_than_or_equal_to: 0 }

  attr_accessor :allocation

  def create_purchase(purchase_params)
    # TODO: RWS - remove this before committing
    puts
    puts %Q(\e[31m#{'>' * 80})
    puts %Q(\e[33mself.inspect:\e[0m #{self.inspect})
    puts %Q(\e[33mself.allocation:\e[0m #{self.allocation})
    puts %Q(\e[33mallocation():\e[0m #{allocation()})
    puts %Q(\e[33mallocation:\e[0m #{allocation})
    puts %Q(\e[31m#{'<' * 80}\e[0m)

    if available?(purchase_params)
      purchase = Purchase.new(purchase_params)
      purchase.ticket_option = self
      purchase.save!

      allocation -= purchase_params[:quantity].to_i
      save!

      purchase
    end
  end

  def available?(purchase_params)
    allocation >= purchase_params[:quantity].to_i
  end
end
