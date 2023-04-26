# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[edit update destroy]

  def index
    @subscriptions = current_user.subscriptions
  end

  def show; end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = current_user.subscriptions.new(subscription_params)
    if @subscription.save
      redirect_to root_path, notice: "サブスクリプション「#{@subscription.name}」を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @subscription.update!(subscription_params)
    redirect_to root_path, notice: "サブスクリプション「#{@subscription.name}」を編集しました。"
  end

  def destroy
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "サブスクリプション「#{@subscription.name}を削除しました", status: :see_other }
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:name, :payment_date, :fee, :my_account_url, :subscribed, :cycle, :user_id)
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
