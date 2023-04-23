# frozen_string_literal: true

module Users
  class CalendarsController < UsersController
    skip_before_action :authenticate, raise: false, only: :index

    def index
      respond_to do |format|
        format.ics do
          calendar = SubscriptionsInIcalFormatExporter.export_subscriptions(set_export)
          calendar.publish
          render plain: calendar.to_ical
        end
      end
    end

    private

    def set_expotr
      Subscription.where('subscribed = ?', true)
    end
  end
end
