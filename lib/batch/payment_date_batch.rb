module Batch
  class PaymentDateBatch
    def self.payment_date_batch
      subscriptions = Subscription.all
      subscriptions.each do |subscription|
        new_payment_date = subscription.calc_next_payment_date
        month = Date.today.month

        Subscription.find(subscription.id).update(payment_date: new_payment_date) if new_payment_date.month == month && subscription.subscribed
      end
    end
  end
end
