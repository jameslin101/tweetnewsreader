class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_user_id, :bigint
    add_column :users, :token, :string
    add_column :users, :secret, :string
    add_column :users, :since_id, :bigint
  end
end
