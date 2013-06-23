class TwitterUser < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.from_raw_info!(raw_info)
    twitter_user = TwitterUser.first_or_initialize(raw_info.id)
    twitter_user_params = twitter_user.attributes.keys
    twitter_user_params.delete("updated_at")
    twitter_user_params.each do |twitter_user_param|
      twitter_user[twitter_user_param] = raw_info[twitter_user_param]
    end
    twitter_user.save!
  end

end
