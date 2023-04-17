module Api
  module V1
    class SubscriptionsController < ApiController
      before_action :set_subscription, only: %i[edit update destroy]

      rescue_from ActiveRecord::RecordNotFound do |_exception|
        render json: { error: '404 not found' }, status: 404
      end

      def index
        subscriptions = Subscription.all
        render json: subscriptions
      end

      private

      def set_subscription
        @subscription = Subscription.find(params[:id])
      end
    end
  end
end
