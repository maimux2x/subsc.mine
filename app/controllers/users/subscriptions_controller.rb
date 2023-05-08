# frozen_string_literal: true

module Users
  class SubscriptionsController < ApplicationController
    skip_before_action :authenticate, raise: false, only: :index

    def index
      @subscriptions = set_export
    end

    private

    def set_export
      user = User.find_by!(id_digest: params[:user_id])
      user.subscriptions.where(subscribed: true)
    end
  end
end
