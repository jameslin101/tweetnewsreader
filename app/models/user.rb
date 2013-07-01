class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :articles

  has_many :timeline_tweets
  # has_many :tweets, :through => :timeline_tweets

  belongs_to :twitter_user

  def timeline
    timeline_tweets.
    where("user_id = ?", self.id).
    joins(:tweet).
    where("tweets.is_article IS TRUE")
  end


  def self.from_omniauth(auth)
    TwitterUser.from_twitter_api!(auth.extra.raw_info)

    if !(user = User.find_by_twitter_user_id(auth.uid))
      user = User.new
      create do |user|
        user.twitter_user_id = auth.uid
        user.token = auth.credentials.token
        user.secret = auth.credentials.secret
      end
    else
      user.token = auth.credentials.token
      user.secret = auth.credentials.secret
      user.save!
      user
    end

  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end

  def password_required?
    false
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def twitter_client
    @twitter_client ||= Twitter::Client.new(
      :oauth_token => self.token,
      :oauth_token_secret => self.secret
    )
  end

  def fetch_timeline
    unless self.since_id
      tweets = twitter_client.home_timeline(:count => 800)
    else
      tweets = twitter_client.home_timeline(:since_id => self.since_id)
    end
    if tweets.present?
      tweets.each do |tweet_data|
        tweet = Tweet.from_twitter_api!(tweet_data, self)
      end
      self.since_id = tweets.max_by(&:id).id
      self.save!
    end
  end


end


