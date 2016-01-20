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
    if User.find_by(email: params[:email])
      userId = User.find_by(email: params[:email]).id
    end
    
    @debt = Debt.new(name: params[:name], amount: params[:amount], paid: false, invoice_id: params[:invoice_id], paid_amount: 0, user_id: userId)

    if @debt.save
      UserMailer.welcome_email(@debt.user.email).deliver_now
      @debt.invoice.toggle_when_paid
      flash[:success] = "debt created"
    else
      flash[:danger]= @debt.errors.full_messages.join("</br>")
    end
    redirect_to "/invoices/#{@debt.invoice_id}"
  end

  def show
    @debt = Debt.find(params[:id])
    redirect_to "/profiles/user" if @debt.user.id != current_user.id
  end

  def edit
    @debt = Debt.find(params[:id])
  end

  def update
    if params[:invoice_edit]
      if User.find_by(email: params[:email])
        user_id = User.find_by(email: params[:email]).id
      end
      debt = Debt.find(params[:id])
      
      if debt.update(user_id: user_id, amount: params[:amount], name: params[:name])
        flash[:success] = "debt created"
        redirect_to "/invoices/#{debt.invoice.id}"
      else
        @debt = Debt.find(params[:id])
        flash[:warning] = debt.errors.full_messages.join("</br>")
        render :edit
      end
      
    else

      @debt = Debt.find(params[:id])

      if ((params[:amount].to_f+Debt.find(params[:id]).paid_amount) > Debt.find(params[:id]).amount)
        flash.now[:danger] = "Your paid amount cannot surpass the debt amount"
        render :show

      else 
        amount_to_update = params[:amount].to_f
        current_amount = 0 
        if Debt.find(params[:id]).paid_amount
        current_amount = Debt.find(params[:id]).paid_amount
        end
        new_amount = amount_to_update + current_amount

        Debt.find(params[:id]).update(paid_amount: new_amount)

        Debt.find(params[:id]).toggle_when_paid
        Debt.find(params[:id]).invoice.toggle_when_paid

        redirect_to "/debts/#{params[:id]}"

        
      end

    end
  end

  def destroy
    debt = Debt.find(params[:id])
    debt.destroy
    debt.invoice.toggle_when_paid
    redirect_to "/invoices/#{debt.invoice.id}"
  end


end
