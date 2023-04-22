module Subscriptions
  class StatusController < ApplicationController
    before_action :set_subscription, only: %i[edit update]

    def edit; end

    def update
      @subscription.update!(subscription_params)
      redirect_to root_path, notice: "サブスクリプション「#{@subscription.name}」を編集しました。"
    end

    private

    def subscription_params
      params.require(:subscription).permit(:name, :payment_date, :fee, :my_account_url, :subscribed, :cycle, :user_id)
    end

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end
  end
end
