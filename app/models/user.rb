class User < ActiveRecord::Base
  has_many :invoices
  has_many :debts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :favoriter_favorites, foreign_key: :favoritee_id, class_name: "Favorite"
  has_many :favoriters, through: :favoriter_favorites

  has_many :favoritee_favorites, foreign_key: :favoriter_id, class_name: "Favorite"
  has_many :favoritees, through: :favoritee_favorites

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

  def unpaid_invoices
    unpaid = []
    invoices.each do |invoice|
      if !invoice.paid
        unpaid << invoice
      end
    end
    return unpaid
  end

  def unpaid_debts
    unpaid = []
    debts.each do |debt|
      if !debt.paid
        unpaid << debt
      end
    end
    return unpaid
  end

  def get_recent_unpaid
    recent_array = []
    unpaid_invoices.each do |invoice|
      recent_array << invoice
    end
    unpaid_debts.each do |debt|
      recent_array << debt
    end
    sorted_array = recent_array.sort_by{ |k| k.updated_at }
    ten_recent = []
    if sorted_array.length < 10
      sorted_array.length.times do
        ten_recent << sorted_array.pop
      end
    else
      10.times do 
        ten_recent << sorted_array.pop
      end
    end
    return ten_recent
  end
end
