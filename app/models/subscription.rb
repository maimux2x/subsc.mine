class Subscription < ApplicationRecord
  validates :name, length: { maximum: 50 }, presence: true
  validates :payment_date, presence: true
  validates :fee, length: { maximum: 7 }, presence: true
  validates :my_account_url, length: { maximum: 200 }
  validates :subscribed, presence: true
  validates :cycle, presence: true
  validate :payment_date_before_this_month

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

  def payment_date_before_this_month
    return if payment_date.blank?

    return unless payment_date.month > Date.today.month

    errors.add("お支払基準日は今月以前の直近の日付を指定してください。")
  end
end
