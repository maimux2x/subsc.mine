class UsersController < ApplicationController
  def show
    @user_id = current_user.id
    p @user_id
  end
end