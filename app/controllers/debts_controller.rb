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
    @debt = Debt.find(params[:id])
  end

  def edit
  end

  def update
    amount_to_update = params[:amount].to_f
    current_amount = 0 
    if Debt.find(params[:id]).paid_amount
      current_amount = Debt.find(params[:id]).paid_amount
    end
    new_amount = amount_to_update + current_amount

    Debt.find(params[:id]).update(paid_amount: new_amount)
    redirect_to "/profiles/show"
  end

  def destroy
  end
end
