# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    redirect_to subscriptions_path if logged_in?
  end

  def tos; end

  def privacy_policy; end
end
