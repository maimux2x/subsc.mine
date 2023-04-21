class Subscription < ApplicationRecord
  belongs_to :user

  def calc_next_payment_date
    duration = calc_duration

    if (duration % cycle).zero?
      payment_date.since(duration.month)
    elsif duration < cycle
      payment_date.since(cycle.month)
    elsif duration > cycle
      duration = (duration.to_f / cycle).ceil
      payment_date.since((duration * cycle).month)
    end
  end

  private

  def calc_duration
    today = Date.today
    year_duration = today.year - payment_date.year
    month_duration = today.month - payment_date.month

    duration = (year_duration * 12) + month_duration
    if duration.zero?
      duration = cycle
    elsif today > payment_date
      duration *= 2
    else
      duration
    end
    duration
  end
end
