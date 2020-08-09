require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  let(:dummy_card) { DummyData::PayjpCard.data }
  let(:card_token) { FactoryBot.build(:card_token, card_token: dummy_card[:id], customer_token: dummy_card[:customer], user: nil) }

  let(:payjp_customer_mock) { double("Payjp::Customer") }
  let(:dummy_payjp_cards) { [ dummy_card ] }

  context 'ログイン済み' do

    before do
      login user
    end

    it '#index ユーザーが既にカードを所持している場合、Card.get_cardで取得したcardがダミーカードと一致' do
      ## Payjp::Customer.retrieveの返り値をpayjp_customer_mockにする
      allow(Payjp::Customer).to receive(:retrieve).and_return(payjp_customer_mock)
      ## payjp_customer_mock.cardsの返り値をdummy_payjp_cardsにする
      allow(payjp_customer_mock).to receive(:cards).and_return(dummy_payjp_cards)

      user.update(card:card_token)  ## ユーザーが既にカードを所持している

      get :index

      expect(assigns(:card)[:customer]).to eq(dummy_card[:customer])
    end  ## /it '#index ユーザーが既にカードを所持している場合、Card.get_cardで取得したcardがダミーカードと一致'

    it '#index ユーザーがカードを所持していない場合、Card.get_cardはnil' do
      get :index
      expect(assigns(:card)).to eq(nil)
    end  ## /it '#index ユーザーがカードを所持していない場合、Card.get_cardはnil'

    it '#create Payjp::Customer.createで作成したcardがダミーカードと一致' do
      ## Payjp::Customer.createの返り値をpayjp_customer_mockにする
      allow(Payjp::Customer).to receive(:create).and_return(payjp_customer_mock)
      ## payjp_customer_mock.idの返り値をdummy_card[:customer]にする
      allow(payjp_customer_mock).to receive(:id).and_return(dummy_card[:customer])

      post :create, params: {payjp_token: "tok_xxxxxxxx", card_token: dummy_card[:id]}

      expect(assigns(:card).customer_token).to eq(dummy_card[:customer])
    end  ## /it '#create Payjp::Customer.createで作成したcardがダミーカードと一致'

  end  ## /context 'カード登録済み'

end  ## /RSpec.describe CardsController
