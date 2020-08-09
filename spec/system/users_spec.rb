require 'rails_helper'

RSpec.describe "Users", type: :system do
  # before do
  #   driven_by(:rack_test)  ## ブラウザを起動しない形式のテストにする
  # end

  ### ◆◆◆追加◆◆◆
  let(:dummy_google_user) { OmniAuth.config.mock_auth[:google_oauth2] }

  context 'SNS認証' do
    it 'Google認証をすると、新規登録画面で既に情報が入力済みになっている' do
      # トップページに移動する
      visit root_path
      # トップページに登録方法の選択ページへ遷移するリンクがある
      expect(page).to have_content('新規会員登録')

      # 登録方法の選択ページへ遷移する
      visit users_select_path
      # Google認証へのリンクがある
      expect(page).to have_content('Googleで登録する')
      # Google認証へのリンクをクリックする
      find('.button', text:"Googleで登録する").click
      ## ーーーーー変更ここからーーーーー
      # この時点で新規登録画面へ遷移している

      # 新規登録画面のニックネーム欄に、Googleから受け取ったユーザー情報（ニックネーム）が入力済みになっている
      expect(
        find('#user_nickname').value
      ).to eq dummy_google_user[:info][:name]
      # 新規登録画面のニックネーム欄に、Googleから受け取ったユーザー情報（email）が入力済みになっている
      expect(
        find('#user_email').value
      ).to eq dummy_google_user[:info][:email]
      ## ーーーーー変更ここまでーーーーー
    end  ## /it 'Google認証をすると、新規登録画面で既に情報が入力済みになっている'
  end  ## /context 'SNS認証' do

end  ## /RSpec.describe "Users"
