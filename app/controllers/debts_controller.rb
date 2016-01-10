class DebtsController < ApplicationController
  # incseud
  def index
    @debts = Debt.all
  end
  
  def new
  end

  def create
    userId = User.find_by(email: params[:email]).id
    @debt = Debt.create(name: params[:name], amount: params[:amount], paid: false, invoice_id: params[:invoice_id], user_id: userId)
    redirect_to "/invoices/#{@debt.invoice_id}"
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
