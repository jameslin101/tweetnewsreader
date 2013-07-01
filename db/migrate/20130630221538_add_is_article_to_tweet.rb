class AddIsArticleToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :is_article, :boolean
  end
end
