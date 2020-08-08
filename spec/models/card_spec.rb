require 'rails_helper'

RSpec.describe Card, type: :model do
  describe "クラスメソッドのテスト" do

    context "正しいカード情報が送られている" do

      let(:user) { FactoryBot.create(:user) }

      ## card_token = cardモデルのオブジェクト
      let(:card_token) { FactoryBot.create(:card_token, user: user ) }

      ## Payjp::Customer.retrieveの返り値の代用品
      let(:payjp_customer_mock) { double("Payjp::Customer") }

      ## ダミーのクレジットカード
      let(:dummy_card) { DummyData::PayjpCard.data }

      ## ダミーの顧客情報
      let(:dummy_customer) { DummyData::PayjpCustomer.data }

      ## ダミーの支払い情報
      let(:dummy_charge) { DummyData::PayjpCharge.data }

      it "card_tokenオブジェクト本来の挙動" do
        puts "ーーーーーーーーーーーーーーーー"
        puts "カスタマーのトークン"
        puts card_token.customer_token
        puts "カードのトークン"
        puts card_token.card_token
        puts "ーーーーーーーーーーーーーーーー"
      end  ## /it "card_tokenオブジェクト本来の挙動"

      it "モックとallowの挙動確認" do
        test_mock = double("TestMock")
        dummy_card_token = "car_abcdefghijklmnopqrstuvwxyz"

        ## card_tokenオブジェクトに対してcustomer_tokenメソッドを実行した時、代わりにtest_mockを返す
        allow(card_token).to receive(:customer_token).and_return(test_mock)

        ## card_tokenオブジェクトに対してcard_tokenメソッドを実行した時、代わりにdummy_card_tokenを返す
        allow(card_token).to receive(:card_token).and_return(dummy_card_token)

        ## test_mockに対してhelloメソッドを実行した時、代わりに"こんにちわ"を返す
        allow(test_mock).to receive(:hello).and_return("こんにちわ")

        puts "ーーーーーーーーーーーーーーーー"
        puts "カスタマーのトークン"
        puts card_token.customer_token
        puts "\nカードのトークン"
        puts card_token.card_token
        puts "\ntest_mockが挨拶をします"
        puts card_token.customer_token.hello
        puts "ーーーーーーーーーーーーーーーー"
      end  ## /it "モックとallowの挙動確認"

      it "self.get_cardメソッド（返り値である「card」が「dummy_card」と一致する）" do
        ## Payjp::Customerに対してretrieveメソッドが実行された時、実行せずにpayjp_customer_mockを返す。
        allow(Payjp::Customer).to receive(:retrieve).and_return(payjp_customer_mock)

        ## ーーーーー追加ここからーーーーー
        ## payjp_customer_mockに対してcardsメソッドが実行された時、実行せずにdummy_payjp_cardsを返す。
        dummy_payjp_cards = [ dummy_card ]
        allow(payjp_customer_mock).to receive(:cards).and_return(dummy_payjp_cards)

        card = Card.get_card(card_token.customer_token)

        expect(card[:id]).to eq(dummy_card[:id])
        ## ーーーーー追加ここまでーーーーー
      end  ## /it "self.get_cardメソッド（返り値である「card」が「dummy_card」と一致する）"

      it "Payjp::Customer.create(card: params[:payjp_token])（返り値である「customer」のidが「dummy_customer」のidと一致する）" do
        ## Payjp::Customerに対してcreateメソッドが実行された時、実行せずにdummy_customerを返す。
        allow(Payjp::Customer).to receive(:create).and_return(dummy_customer)

        customer = Payjp::Customer.create(card: "tok_XXXXXXXXXXXXX")
        expect(customer[:id]).to eq(dummy_customer[:id])
      end

      it "Payjp::Charge.create(amount: hoge, customer: fuga, currency: jpy)（返り値である「charge」のcustomerが「dummy_charge」のcustomerと一致する）" do
        ## Payjp::Customerに対してcreateメソッドが実行された時、実行せずにdummy_customerを返す。
        allow(Payjp::Charge).to receive(:create).and_return(dummy_charge)

        charge = Payjp::Charge.create(
          amount: 1000, # 商品の値段
          customer: "cus_XXXXXXXXXXXX", # 顧客、もしくはカードのトークン
          currency: 'jpy'  # 通貨の種類
        )
        binding.pry
        expect(charge[:customer]).to eq(dummy_charge[:customer])
      end

    end  ## /context "正しいカード情報が送られている"

  end  ## /describe "クラスメソッドのテスト"

end  ## /RSpec.describe Card
