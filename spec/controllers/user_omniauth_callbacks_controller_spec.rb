require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  context 'Google認証のテスト' do

    ## ◆◆◆追加◆◆◆
    let(:dummy_google_user) { OmniAuth::AuthHash.new(DummyData::GoogleUser.data) }

    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth::AuthHash.new(DummyData::GoogleUser.data)
    end

    it 'Googleで認証後に返ってくるauth情報がダミーデータと一致する' do
      post 'google_oauth2'

      puts "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー"
      puts "session['devise.sns_auth'][:user].email: #{session["devise.sns_auth"][:user].email}"
      puts "dummy_google_user.info.email: #{dummy_google_user.info.email}"
      puts "\nsession[:sns_credential].uid: #{session["devise.sns_auth"][:sns_credential].uid}"
      puts "dummy_google_user.uid: #{dummy_google_user.uid}"
      puts "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー"

      expect(session["devise.sns_auth"][:user].email).to eq dummy_google_user.info.email
      expect(session["devise.sns_auth"][:sns_credential].uid).to eq dummy_google_user.uid
    end

  end

end
