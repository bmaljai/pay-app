class Debt < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :user

  validates :name, :amount, presence: true
  validate :valid_user
  validates :amount, numericality: true
  validates :amount, numericality: {greater_than: 0}

  validate :debt_less_than_invoice_amount_minus_debts, on: :create
  validate :exclude_current_user_from_debt

  def exclude_current_user_from_debt
    if user_id == invoice.user.id
      errors.add(:user_id, "cannot assign debts to yourself")
    end
  end

  def debt_less_than_invoice_amount_minus_debts
      if ((amount.to_f > invoice.valid_debt_amount) || (amount.to_f < 0))
        errors.add(:amount, "Invalid Amount")
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

  def toggle_when_paid
    if outstanding_balance == 0
      update(paid: true)
    end
  end



end
