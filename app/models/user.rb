class User < ActiveRecord::Base
  has_many :invoices
  has_many :debts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def user_debt
    total_debt = 0
    debts.each do |debt|
      total_debt += debt.outstanding_balance 
    end
    return total_debt
  end

  def user_owed
    total_owed = 0
    invoices.each do |invoice|
      total_owed += invoice.others_owe
    end
    return total_owed
  end

  def user_balance
    return user_owed - user_debt
  end
end
