class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    callback_for(:google)
  end

  def facebook
    callback_for(:facebook)
  end

  def callback_for(provider)
    session["devise.sns_auth"] = User.from_omniauth(request.env["omniauth.auth"])

    if session["devise.sns_auth"][:user].persisted?
      ## userが登録済み
      sign_in_and_redirect session["devise.sns_auth"][:user], event: :authentication
    else
      ## @userが未登録
      redirect_to new_user_registration_path
    end

  end
end

