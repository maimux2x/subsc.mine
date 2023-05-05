# frozen_string_literal: true

module SubscriptionDecorator
  def subscribed_status
    subscribed ? '継続中' : '停止中'
  end
end
