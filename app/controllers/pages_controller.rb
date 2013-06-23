class PagesController < ApplicationController
  protect_from_forgery

  def home
    if user_signed_in?
      @things = current_user.twitter_client.home_timeline
    end
  end

end
