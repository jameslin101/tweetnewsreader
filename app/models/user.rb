class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  belongs_to :twitter_user

  def self.from_omniauth(auth)
    TwitterUser.from_raw_info!(auth.extra.raw_info)

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

  # def pull_feed
  #   @twitter_client.
end


