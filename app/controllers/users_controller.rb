class UsersController < ApplicationController
  def show
    @user_id = current_user.id
  end
end
