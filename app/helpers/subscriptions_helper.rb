module SubscriptionsHelper
  def google_calendar_url(subscription)
    uri = URI('http://www.google.com/calendar/render')
    uri.query =
      {
        action: 'TEMPLATE',
        text: subscription.name,
        dates: "#{subscription.calc_next_payment_date.strftime('%Y%m%dT%H%M%S')}/#{subscription.calc_next_payment_date.strftime('%Y%m%dT%H%M%S')}",
        details: "http://localhost/#{subscription.id}"
      }.to_param
    uri.to_s
  end
end
