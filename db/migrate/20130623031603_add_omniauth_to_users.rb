class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_user_id, :integer, :limit => 8
    add_column :users, :token, :string
    add_column :users, :secret, :string
  end
end
