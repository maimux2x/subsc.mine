# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def index
    @subscriptions = current_user.subscriptions
  end

  def show; end

  def new
    @subscription = Subscription.new
  end

  def create
    subscription = current_user.subscriptions.new(subscription_params)
    subscription.save!
    redirect_to root_path, notice: "サブスクリプション「#{subscription.name}」を登録しました。"
  end

  def edit
    @subscription = Subscription.find(params[:id])
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update!(subscription_params)
    redirect_to root_path, notice: "サブスクリプション「#{subscription.name}」を編集しました。"
  end

  def delete; end

  private

  def subscription_params
    params.require(:subscription).permit(:name, :payment_date, :fee, :my_account_url, :subscribed, :cycle, :user_id)
  end
end
