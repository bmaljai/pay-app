class ProfilesController < ApplicationController
  def index
  end

  def show
    if current_user
      @user = current_user
      
      @sorted_recent = @user.get_recent_unpaid

      @invoices = Invoice.where(user_id: current_user.id)
      @debts = Debt.where(user_id: current_user.id)
      @invoices.each do |invoice|
        invoice.toggle_when_paid
      end

    else
      redirect_to "/pages"
    end
  end

  def recent
    if current_user
     @user = current_user
     @sorted_recent = @user.get_recent_unpaid
    else
      redirect_to "/pages"
    end
  end

  def statistics
    @debts = Debt.where(user_id: current_user.id)
  end
end
