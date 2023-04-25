class UsersController < ApplicationController
  skip_before_action :authenticate, raise: false, only: :index
  def show
    @user_id = current_user.id
  end
end