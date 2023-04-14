class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :name, null: false
      t.date :payment_date, null: false
      t.integer :fee, null: false
      t.string :my_account_url
      t.boolean :subscribed, default: false, null: false
      t.integer :cycle, null: false

      t.timestamps
    end
  end
end
