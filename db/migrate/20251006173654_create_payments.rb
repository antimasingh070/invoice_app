class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.references :invoice, null: false, foreign_key: true
      t.integer :payment_method_id
      t.integer :amount

      t.timestamps
    end
  end
end
