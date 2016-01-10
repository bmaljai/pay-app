class Invoice < ActiveRecord::Base
  has_many :debts
  belongs_to :user

  def others_owe
    owed = 0
    debts.each do |debt|
      owed += debt.amount
    end
    return owed
  end

  def others_paid
    paid = 0
    debts.each do |debt|

      if debt.paid_amount == nil 
        paid += 0
      else
        paid += debt.paid_amount
      end
    
    end

    return paid
  end

  def chump_value
    return amount - others_paid
  end

end
