class ProfilesController < ApplicationController

  def index
  end

  def show
    if current_user
      @user = current_user
      @invoices = Invoice.where(user_id: current_user.id)
      @debts = Debt.where(user_id: current_user.id)
    else
      redirect_to "/pages/landing"
    end
  end

  def recent
    @user = current_user
    @sorted_recent = @user.get_recent

  end
end
