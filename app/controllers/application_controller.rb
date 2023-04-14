# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?

  private

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
