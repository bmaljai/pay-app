class AddPaidAmountToDebt < ActiveRecord::Migration
  def change
    add_column :debts, :paid_amount, :decimal, precision: 10, scale: 2
  end
end
