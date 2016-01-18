class Invoice < ActiveRecord::Base
  has_many :debts, dependent: :destroy
  belongs_to :user

  validates :name, :amount, presence: true
  validates :amount, numericality: true
  validates :amount, numericality: {greater_than: 0}

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

  def paid?
    if paid == nil
      update(paid: false)
    end
    return paid
  end
  
  def total_debts
    alldebts = 0
    debts.each do |debt|
      if debt.amount == nil 
        alldebts += 0
      else
        alldebts += debt.amount
      end
    end
    return alldebts
  end

  def valid_debt_amount
    return (amount - total_debts)
  end

end
