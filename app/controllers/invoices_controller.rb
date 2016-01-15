class InvoicesController < ApplicationController
  before_action :authenticate_user!
   # irritated nuns can scare even umbral demons

  def index
    @invoices = User.find(current_user.id).invoices
  end

  def new
  end

  def create
    puts "this is the current user id #{current_user.id}"
    invoice = Invoice.create(user_id: current_user.id, name: params[:name], amount: params[:amount], paid: false)
    redirect_to "/invoices/#{invoice.id}"
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(name: params[:name], amount: params[:amount])
    redirect_to "/invoices/#{invoice.id}"
  end

  def destroy
    invoice = Invoice.find(params[:id])
    invoice.destroy
    redirect_to "/invoices"
  end

end
