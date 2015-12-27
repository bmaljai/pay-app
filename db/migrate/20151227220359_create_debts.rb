class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.string :name
      t.string :date
      t.text :description
      t.decimal :amount, precision: 10, scale: 2
      t.boolean :paid
      t.string :paid_date
      t.string :due_date
      t.boolean :overdue

      t.timestamps null: false
    end
  end
end
