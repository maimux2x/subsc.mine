# frozen_string_literal: true

class SubscriptionsInIcalFormatExporter
  def self.export_subscriptions(subscriptions)
    cal = Icalendar::Calendar.new
    subscriptions.each do |subscription|
      tzid = 'Asia/Tokyo'

      cal.event do |e|
        e.dtstart     = Icalendar::Values::DateTime.new subscription.calc_next_payment_date, { 'tzid' => tzid }
        e.dtend       = Icalendar::Values::DateTime.new subscription.calc_next_payment_date, { 'tzid' => tzid }
        e.summary     = subscription.name
        e.uid         = "subscription#{subscription.id}"
        e.sequence    = Time.now.to_i
      end
    end
    cal
  end
end
