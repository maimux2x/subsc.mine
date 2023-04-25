# frozen_string_literal: true

module Users
  class SubscriptionsController < ApplicationController
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

    def set_export
      Subscription.where(user_id: params[:user_id], subscribed: true)
    end
  end
end
