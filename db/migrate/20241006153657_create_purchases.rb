class CreatePurchases < ActiveRecord::Migration[7.2]
  def change
    create_table :purchases, id: :uuid do |t|
      t.integer :quantity
      t.uuid :user_id
      t.references :ticket_option

      t.timestamps
    end
  end
end
