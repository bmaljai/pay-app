class ProfilesController < ApplicationController
  def show
    @invoices = Invoice.where(user_id: current_user.id)
    @debts = Debt.where(user_id: current_user.id)
  end
end
