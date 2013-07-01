class CreateTimelineTweets < ActiveRecord::Migration
  def change
    create_table :timeline_tweets do |t|
      t.integer :user_id
      t.integer :tweet_id, :limit => 8
      t.boolean :favorited
      t.boolean :retweeted
      t.datetime :read_at
      t.timestamps
    end
  end
end
