class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      sign_in_and_redirect user, notice: "Signed in!"
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to user_omniauth_authorize_path(:twitter)
    end

  end

  alias_method :twitter, :all

end
