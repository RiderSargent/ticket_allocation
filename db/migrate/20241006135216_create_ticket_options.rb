class CreateTicketOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :ticket_options, id: :uuid do |t|
      t.string :name
      t.text :desc
      t.integer :allocation

      t.timestamps
    end
  end
end
