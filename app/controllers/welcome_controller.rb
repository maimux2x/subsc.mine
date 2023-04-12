# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    redirect_to subscriptions_path if logged_in?
  end
end
