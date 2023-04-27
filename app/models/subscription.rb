class Subscription < ApplicationRecord
  validates :name, length: { maximum: 50 }, presence: true
  validates :payment_date, presence: true
  validates :fee, length: { maximum: 7 }, presence: true
  validates :my_account_url, length: { maximum: 200 }
  validates :subscribed, inclusion: { in: [true, false] }
  validates :cycle, presence: true
  validate :payment_date_before_this_month

  belongs_to :user

  def calc_next_payment_date
    duration = calc_duration

    if (duration % cycle).zero?
      # 経過月数と周期の余りが0の場合は経過月数で次回お支払日を算出
      payment_date.since(duration.month)
    elsif duration < cycle
      # 経過月数が周期未満だったら周期で次回お支払日を算出
      payment_date.since(cycle.month)
    elsif duration > cycle
      # 経過月数が周期より大きかったら経過月数と周期を割った切り上げ結果に周期をかけて次回お支払日を算出
      duration = (duration.to_f / cycle).ceil
      payment_date.since((duration * cycle).month)
    end
  end

  private

  def calc_duration
    # お支払基準日からの経過を本日との差分で算出
    today = Date.current
    # 年の経過の差分を算出
    year_duration = today.year - payment_date.year
    # 月の経過の差分を算出
    month_duration = today.month - payment_date.month
    # 年を月単位に変換し、合計の経過月数を算出
    duration = (year_duration * 12) + month_duration

    if today >= payment_date && cycle == 1
      duration += 1
    elsif duration.zero?
      duration = cycle
    else
      duration
    end
    duration
  end

  def payment_date_before_this_month
    return if payment_date.blank?

    return unless payment_date.year >= Date.current.year && payment_date.month > Date.current.month

    errors.add(:payment_date, "お支払基準日は今月以前の直近の日付を指定してください。")
  end
end
