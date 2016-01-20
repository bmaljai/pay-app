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
    invoice = Invoice.new(user_id: current_user.id, name: params[:name], amount: params[:amount], paid: false)
    if invoice.save
      flash[:success] = "Invoice created"
      redirect_to "/invoices/#{invoice.id}"
    else
      flash[:warning]= invoice.errors.full_messages.join("</br>")
      render :new
    end
    
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice.toggle_when_paid
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
