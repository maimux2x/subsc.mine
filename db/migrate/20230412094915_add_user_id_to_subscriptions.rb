class AddUserIdToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :subscriptions, :user, null: false, index: true
  end
end
