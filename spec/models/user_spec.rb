require 'rails_helper'

RSpec.describe User, type: :model do

  describe "新規登録" do

    context "クラスメソッドのテスト" do

      let(:dummy_google_user) { OmniAuth::AuthHash.new(DummyData::GoogleUser.data) }
      let(:sns_credential) { FactoryBot.build(:sns_credential)}

      it "self.from_omniauth(auth_data) ダミーデータを使って実際に動作させる" do
        session_devise_sns_auth = User.from_omniauth(dummy_google_user)

        puts "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー"
        puts "session_devise_sns_auth[:user: #{session_devise_sns_auth[:user].email}"
        puts "dummy_google_user.info.email: #{dummy_google_user.info.email}"

        puts "\nsession_devise_sns_auth[:sns_credential].uid: #{session_devise_sns_auth[:sns_credential].uid}"
        puts "dummy_google_user.uid: #{dummy_google_user.uid}"
        puts "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー"

        expect(session_devise_sns_auth[:user].email).to eq dummy_google_user.info.email
        expect(session_devise_sns_auth[:sns_credential].uid).to eq dummy_google_user.uid
      end  ## /it "self.from_omniauth(auth_data) ダミーデータを使って実際に動作させる"

      it "self.from_omniauth(auth_data) allow().to〜で返り値を強制変更する" do
        allow(User).to receive(:from_omniauth).and_return(
          {
            user: sns_credential.user,
            sns_credential: sns_credential
          }
        )
        session_devise_sns_auth = User.from_omniauth("hoge")

        puts "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー"
        puts "session_devise_sns_auth[:user].email: #{session_devise_sns_auth[:user].email}"
        puts "sns_credential.user.email: #{sns_credential.user.email}"

        puts "\nsession_devise_sns_auth[:sns_credential].uid: #{session_devise_sns_auth[:sns_credential].uid}"
        puts "sns_credential.uid: #{sns_credential.uid}"
        puts "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー"

        expect(session_devise_sns_auth[:user].email).to eq sns_credential.user.email
        expect(session_devise_sns_auth[:sns_credential].uid).to eq sns_credential.uid
      end  ## /it "self.from_omniauth(auth_data) allow().to〜で返り値を強制変更する"

    end  ## /context "クラスメソッドのテスト"

    # context "登録に成功する" do

    # let(:user) {FactoryBot.build(:user)}

    #   it "全て正しく入力されている" do
    #     expect(user).to be_valid
    #     # puts user.attributes
    #   end

    # end

    # context "登録に失敗する" do

    #   let(:user) {FactoryBot.build(:user)}
    #   let(:user2) {FactoryBot.build(:user, email: user.email)}

    #   after(:example) do
    #     puts "ーーーーーーーーーーーーー"
    #     puts user.errors.full_messages
    #     puts user.attributes
    #     puts "ーーーーーーーーーーーーー"
    #   end

    #   def invalid_details(data)  ## エラーが出る時の情報
    #   end

    #   it "emailがない" do
    #     user.email = ""
    #     expect(user).to_not be_valid
    #     invalid_details(user)
    #   end

    #   it "emailに@がない" do
    #     user.email = "hogehoga.com"
    #     expect(user).to_not be_valid
    #     invalid_details(user)
    #   end

    #   it "emailが重複している" do
    #     user
    #     user2
    #     user.save
    #     expect(user2).to_not be_valid
    #     invalid_details(user2)
    #   end

    #   it "passwordが8文字未満" do
    #     user.password = "hoge1"
    #     expect(user).to_not be_valid
    #     invalid_details(user)
    #   end

    #   it "passwordに数字がない" do
    #     user.password = "hogefuga"
    #     expect(user).to_not be_valid
    #     invalid_details(user)
    #   end

    #   it "passwordにアルファベットがない" do
    #     user.password = "12345678"
    #     expect(user).to_not be_valid
    #     invalid_details(user)
    #   end

    #   it "first_nameの読みはカタカナである必要がある" do
    #     user.first_name_reading = "あいうえお"
    #     expect(user).to_not be_valid
    #     invalid_details(user)
    #   end

    #   it "last_nameの読みはカタカナである必要がある" do
    #     user.last_name_reading = "かきくけこ"
    #     expect(user).to_not be_valid
    #     invalid_details(user)
    #   end

    # end



  end  ## /describe "新規登録"

end  ## /RSpec.describe User
