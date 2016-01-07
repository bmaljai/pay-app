class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :user_id
      t.string :name
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
