class Tweet < ActiveRecord::Base
  attr_accessible :is_article, :favorite_count, :retweet_count, :text, :text_stripped

  belongs_to :twitter_user
  has_many :url_entities, :dependent => :destroy
  has_many :timeline_tweets, :dependent => :destroy

  def self.from_twitter_api!(tweet_data, user)
    tweet = Tweet.where(:id => tweet_data.id).first_or_initialize
    if tweet.new_record?
      tweet.text = tweet_data.text
      tweet.favorite_count = tweet_data.favorite_count
      tweet.retweet_count = tweet_data.retweet_count
      tweet.created_at = tweet_data.created_at
      tweet.twitter_user = TwitterUser.from_twitter_api!(tweet_data.user)
      tweet.save!
      tweet_data.urls.each do |url|
        url_entity = UrlEntity.from_twitter_api!(url, tweet.id)
      end
    else
      tweet.favorite_count = tweet_data.favorite_count
      tweet.retweet_count = tweet_data.retweet_count
      tweet.save!
    end
    if !TimelineTweet.find_by_tweet_id_and_user_id(tweet.id, user.id)    
      TimelineTweet.create!(:tweet_id => tweet.id, 
                            :user_id => user.id,
                            :favorited => tweet_data.favorited,
                            :retweeted => tweet_data.retweeted)
    end
    return tweet
  end

  def url
    url_entities.first
  end

end
