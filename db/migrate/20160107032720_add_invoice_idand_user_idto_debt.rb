class AddInvoiceIdandUserIdtoDebt < ActiveRecord::Migration
  def change
    add_column :debts, :invoice_id, :integer
    add_column :debts, :user_id, :integer
  end
end
