class Debt < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :user

  validates :name, :amount, presence: true
  validate :valid_user
  validates :amount, numericality: true
  validates :amount, numericality: {greater_than: 0}

  validate :debt_less_than_invoice_amount_minus_debts

  def debt_less_than_invoice_amount_minus_debts
      if ((amount.to_f > invoice.valid_debt_amount) || (amount.to_f < 0))
        errors.add(:amount, "Amount is too high")
      end
  end

  def valid_user
    if !user_id
      errors.add(:user_id, "Invalid email")
    end
  end


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

  def paid?
    if paid == nil
      paid = false
    end
    return paid
  end



end
