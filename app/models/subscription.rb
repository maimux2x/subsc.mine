class Subscription < ApplicationRecord
  belongs_to :user

  def calc_next_payment_date
    payment_date.since(cycle.month)
  end
end
