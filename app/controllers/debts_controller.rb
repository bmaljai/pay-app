class DebtsController < ApplicationController
  def index
    @debts = Debt.all
  end
end
