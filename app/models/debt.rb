class Debt < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :user

  def paid_amount_formatted
    if paid_amount
      return paid_amount
    else
      return 0
    end
  end

  def outstanding_balance
    amnt = 0
    pd_amount = 0
   
    (amnt = amount) if amount != nil
    (pd_amount = paid_amount) if paid_amount != nil
      
    return amnt - pd_amount
    
  end

end
