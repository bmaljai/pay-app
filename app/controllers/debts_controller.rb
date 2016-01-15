class DebtsController < ApplicationController
   before_action :authenticate_user!
  # incseud
  # irritated nuns can scare even umbral demons
  def index
    @debts = Debt.where(user_id: current_user.id)
  end
  
  def new
  end

  def create
    userId = User.find_by(email: params[:email]).id
    @debt = Debt.create(name: params[:name], amount: params[:amount], paid: false, invoice_id: params[:invoice_id], user_id: userId)
    UserMailer.welcome_email(@debt.user.email).deliver_now
    redirect_to "/invoices/#{@debt.invoice_id}"
  end

  def show
    @debt = Debt.find(params[:id])
  end

  def edit
    @debt = Debt.find(params[:id])
  end

  def update
    if params[:invoice_edit]
      user_id = User.find_by(email: params[:email]).id
      debt = Debt.find(params[:id])
      debt.update(user_id: user_id,amount: params[:amount], name: params[:name])
      redirect_to "/invoices/#{debt.invoice.id}"
    else
      amount_to_update = params[:amount].to_f
      current_amount = 0 
      if Debt.find(params[:id]).paid_amount
        current_amount = Debt.find(params[:id]).paid_amount
      end
      new_amount = amount_to_update + current_amount

      Debt.find(params[:id]).update(paid_amount: new_amount)
      redirect_to "/profiles/show"
    end
  end

  def destroy
    debt = Debt.find(params[:id])
    debt.destroy
    redirect_to "/invoices/#{debt.invoice.id}"
  end
end
