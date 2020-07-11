require 'rails_helper'

RSpec.describe User, type: :model do

  describe "新規登録" do

    context "登録に成功する" do

    let(:user) {FactoryBot.build(:user)}

      it "全て正しく入力されている" do
        binding.pry
        expect(user).to be_valid
        # puts user.attributes
      end

    end

    context "登録に失敗する" do

      let(:user) {FactoryBot.build(:user)}
      let(:user2) {FactoryBot.build(:user, email: user.email)}

      after(:example) do
        puts "ーーーーーーーーーーーーー"
        puts user.errors.full_messages
        puts user.attributes
        puts "ーーーーーーーーーーーーー"
      end

      def invalid_details(data)  ## エラーが出る時の情報
      end

      it "emailがない" do
        user.email = ""
        expect(user).to_not be_valid
        invalid_details(user)
      end

      it "emailに@がない" do
        user.email = "hogehoga.com"
        expect(user).to_not be_valid
        invalid_details(user)
      end

      it "emailが重複している" do
        user
        user2
        user.save
        expect(user2).to_not be_valid
        invalid_details(user2)
      end

      it "passwordが8文字未満" do
        user.password = "hoge1"
        expect(user).to_not be_valid
        invalid_details(user)
      end

      it "passwordに数字がない" do
        user.password = "hogefuga"
        expect(user).to_not be_valid
        invalid_details(user)
      end

      it "passwordにアルファベットがない" do
        user.password = "12345678"
        expect(user).to_not be_valid
        invalid_details(user)
      end

      it "first_nameの読みはカタカナである必要がある" do
        user.first_name_reading = "あいうえお"
        expect(user).to_not be_valid
        invalid_details(user)
      end

      it "last_nameの読みはカタカナである必要がある" do
        user.last_name_reading = "かきくけこ"
        expect(user).to_not be_valid
        invalid_details(user)
      end

    end

  end

end
