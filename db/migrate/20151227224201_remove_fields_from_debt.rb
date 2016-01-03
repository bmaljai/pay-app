class RemoveFieldsFromDebt < ActiveRecord::Migration
  def change
    remove_column :debts, :description, :text
    remove_column :debts, :paid_date, :string
    remove_column :debts, :due_date, :string
    remove_column :debts, :overdue, :boolean
  end
end
