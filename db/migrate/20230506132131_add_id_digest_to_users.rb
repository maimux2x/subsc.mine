class AddIdDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :id_digest, :string
  end
end
