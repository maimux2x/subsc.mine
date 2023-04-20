module Batch
  class PaymentDateBatch
    def self.payment_date_batch
      subscriptions = Subscription.all
      subscriptions.each do |subscription|
        payment_date = subscription.payment_date
        cycle = subscription.cycle
        new_payment_date = payment_date.since(cycle.month)

        Subscription.find(subscription.id).update(payment_date: new_payment_date)
      end
    end
  end
end
