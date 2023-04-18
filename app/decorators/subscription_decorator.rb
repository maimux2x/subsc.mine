module SubscriptionDecorator
  def calc_next_payment_date
    I18n.l payment_date.since(cycle.month), format: :short
  end
end
