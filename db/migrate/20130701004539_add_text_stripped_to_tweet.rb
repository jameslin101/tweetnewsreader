class AddTextStrippedToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :text_stripped, :string
  end
end
