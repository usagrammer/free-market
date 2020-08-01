require 'rails_helper'

RSpec.describe Card, type: :model do

  describe "登録" do

    context "登録に成功する" do
    end

    context "登録に失敗する" do
    end

    context "クラスメソッドのテスト" do

      let(:user) { FactoryBot.create(:user) }
      let(:card_token) { FactoryBot.create(:card_token, user: user ) }
      let(:dummy_card) { DummyData::PayjpCard.data }
      let(:payjp_customer_mock) { double("Payjp::Customer")}
      let(:payjp_cards) { [ DummyData::PayjpCard.data ] }

      it "self.get_cardメソッドの返り値であるcardがdummy_cardと一致する" do
        ## モックを使うことで

        # def self.get_card(customer_token)  ## カード情報を取得する。支払い方法ページで使用する。
        #   Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
        #   customer = Payjp::Customer.retrieve(customer_token)
        #   card_data = customer.cards.first
        # end

        ## でPAYJPと通信が発生することを防ぐ

        ## Payjp::Customerに対してretrieveメソッドが呼ばれたら、返り値としてpayjp_customer_mockを返す
        allow(Payjp::Customer).to receive(:retrieve).and_return(payjp_customer_mock)

        ## payjp_customer_mockに対してcardsメソッドが呼ばれたら、返り値としてpayjp_cardsを返す
        allow(payjp_customer_mock).to receive(:cards).and_return(payjp_cards)

        card = Card.get_card(card_token.customer_token)
        ## card => {
        #   "id": "car_60ebbd5f4a1908b689fe0151f2b2",
        #   〜略〜
        #   "exp_month": 9,
        #   "exp_year": 2024,
        #   "last4": "4242",
        # }
        expect(card).to eq dummy_card
      end

    end

  end

end
