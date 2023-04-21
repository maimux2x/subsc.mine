# frozen_string_literal: true

module Subscriptions
  class CalendarsController < ApplicationController
    # skip_before_action :require_active_user_login, raise: false, only: :index

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

    def set_export
      Subscription.where(subscribed: true)
    end
  end
end
