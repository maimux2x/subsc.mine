# frozen_string_literal: true

module subscriptions
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
  
      def users
        public_method(:index).super_method.call
      end

      def set_export
        Subscription.where('subscribed = ? and user_id = ?', true, users.id)
      end
    end
  end
end
