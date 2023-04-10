class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true

      t.timestamps
    end
  end
end
