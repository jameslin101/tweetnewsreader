class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :name
      t.string :description
      t.integer :id, :limit => 8
      t.integer :favourites_count
      t.integer :friends_count
      t.integer :followers_count
      t.string :profile_image_url
      t.string :screen_name
      t.string :time_zone
      t.boolean :verified
      t.boolean :protected
      t.timestamps
    end
    change_column :twitter_users, :id, 'bigint'
  end
end
