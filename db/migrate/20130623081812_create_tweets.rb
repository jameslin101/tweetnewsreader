class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :id, :limit => 8
      t.integer :favorite_count
      t.integer :twitter_user_id, :limit => 8
      t.integer :retweet_count
      t.boolean :possibly_sensitive
      t.string  :text

      t.timestamps
    end
    change_column :tweets, :id, 'bigint'

  end
end
