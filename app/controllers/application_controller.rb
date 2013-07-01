class ApplicationController < ActionController::Base
  protect_from_forgery

  @bitly_client ||= Bitly.client
  
end
