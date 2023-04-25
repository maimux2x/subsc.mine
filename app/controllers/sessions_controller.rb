# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def new; end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.from_omniauth(auth_hash)
    if user.save
      session[:user_id] = user.id
      redirect_to subscriptions_path, notice: 'ログインしました。'
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'ログアウトしました。'
  end
end
