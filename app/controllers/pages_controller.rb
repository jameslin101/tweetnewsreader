class PagesController < ApplicationController
  protect_from_forgery

  def home
    if user_signed_in?
      current_user.fetch_timeline
      @articles = current_user.timeline.order(:created_at).limit(50)  
    else
      render :landing
    end
  end

  def landing
  end

end
