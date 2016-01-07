class DebtsController < ApplicationController
  # incseud
  def index
    @debts = Debt.all
  end
  
  def new
  end

  def create
    userId = User.findby(email: params[:email]).id
    @debt = Debt.create(name: params[:name], email: params[:email], amount: params[:amount], invoice_id: params[:invoice_id], user_id: userId)
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
