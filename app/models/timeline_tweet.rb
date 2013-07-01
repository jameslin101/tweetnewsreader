class TimelineTweet < ActiveRecord::Base
  attr_accessible :tweet_id, :user_id, :favorited, :retweeted, :read_at

  belongs_to :tweet

  belongs_to :user

end
