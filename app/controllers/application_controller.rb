class ApplicationController < ActionController::API
  # This is our new function that comes before Devise's one
  # before_action :authenticate_user_from_token!
  # This is Devise's authentication
  # before_action :authenticate_user!

  private

  def authenticate_user_from_token!
    user_token = request.headers["HTTP_AUTH_TOKEN"]
    user = user_token && User.find_by(authentication_token: user_token.to_s)
    if user
      sign_in user, store: false
    end
  end
end
