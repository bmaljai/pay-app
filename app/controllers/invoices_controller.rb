class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @invoices = User.find(current_user.id).invoices
  end

  def new
  end

  def create
    puts "this is the current user id #{current_user.id}"
    invoice = Invoice.create(user_id: current_user.id, name: params[:name], amount: params[:amount])
    redirect_to "/invoices/#{invoice.id}"
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

end
