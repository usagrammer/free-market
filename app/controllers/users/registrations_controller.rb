# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  prepend_before_action :check_recaptcha, only: [:create]
  before_action :session_has_not_user, only: [:confirm_phone, :new_address, :create_address, :completed]
  before_action :session_has_not_address, only: [:completed]
  layout 'no_menu'

  # GET /resource/sign_up
  def new
    if session["devise.sns_auth"]
      ## session["devise.sns_auth"]がある＝sns認証
      build_resource(session["devise.sns_auth"]["user"])
      @sns_auth = true
    else
      ## session["devise.sns_auth"]がない=sns認証ではない
      super
    end
  end

  # POST /resource
  def create

    if session["devise.sns_auth"]
      ## SNS認証でユーザー登録をしようとしている場合
      ## パスワードが未入力なのでランダムで生成する
      password = Devise.friendly_token[8,12] + "1a"
      ## 生成したパスワードをparamsに入れる
      params[:user][:password] = password
      params[:user][:password_confirmation] = password
    end

    build_resource(sign_up_params)  ## @user = User.new(user_params) をしているイメージ
    unless resource.valid? ## 登録に失敗したとき
      ## 進捗バー用の@progressとflashメッセージをセットして戻る
      @progress = 1
      flash.now[:alert] = resource.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}  ## sessionに@userをencrypted_password込で入れる
    session["devise.regist_data"][:user][:password] = params[:user][:password]  ## 暗号化前のパスワードをsessionに入れる
    respond_with resource, location: after_sign_up_path_for(resource)  ## リダイレクト
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def select  ##登録方法の選択ページ
    session.delete("devise.sns_auth")## 追加
    @auth_text = "で登録する"
  end

  def confirm_phone
  end

  def new_address
    @address = Address.new
  end

  def create_address
    @address = Address.new(address_params)
    if @address.valid? ## バリデーションに引っかからない（save可能な）時
      session["devise.regist_data"][:address] = @address
      redirect_to users_completed_path
    else  ## バリデーションに引っかかる（save不可な）時
      redirect_to users_new_address_path, alert: @address.errors.full_messages
    end
  end

  def completed
    @progress = 5
    @user = build_resource(session["devise.regist_data"]["user"])
    @user.build_sns_credential(session["devise.sns_auth"]["sns"]) if session["devise.sns_auth"] ## sessionがあるとき＝sns認証でここまできたとき
    @user.build_address(session["devise.regist_data"]["address"])
    if @user.save
      sign_up(resource_name, resource)  ## ログインさせる
    else
      redirect_to root_path, alert: @user.errors.full_messages
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
  def after_sign_up_path_for(resource)
    users_confirm_phone_path
  end

  def check_recaptcha
    redirect_to new_user_registration_path unless verify_recaptcha(message: "reCAPTCHAを承認してください")
  end

  def address_params
    params.require(:address).permit(
      :phone_number,
      :postal_code,
      :prefecture_id,
      :city,
      :house_number,
      :building_name,
      )
  end

  def session_has_not_user
    unless session["devise.regist_data"]&.dig("user").present?
      redirect_to new_user_registration_path, alert: "会員情報を入力してください。"
    end
  end

  def session_has_not_address
    unless session["devise.regist_data"]&.dig("address").present?
      redirect_to new_user_registration_path, alert: "会員情報を入力してください。"
    end
  end

end
