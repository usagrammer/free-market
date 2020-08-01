require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  # let(:card_token) { FactoryBot.create(:card_token, user: user ) }
  let(:dummy_card) {DummyData::PayjpCard.data}

  context 'log in' do

    before do
      login user

      payjp_customer_mock = double("Payjp::Customer")
      payjp_cards = [DummyData::PayjpCard.data]
      allow(Payjp::Customer).to receive(:retrieve).and_return(payjp_customer_mock)
      allow(payjp_customer_mock).to receive(:cards).and_return(payjp_cards)

      allow(Payjp::Customer).to receive(:create).and_return(payjp_customer_mock)
      allow(payjp_customer_mock).to receive(:id).and_return(payjp_cards.first[:customer])
    end

    it '#index' do
      @card_token = FactoryBot.create(:card_token, user: user )
      get :index
      expect(assigns(:card)[:customer_id]).to eq(dummy_card[:customer_id])
    end

    it '#create' do
      post :create, params: {payjp_token: "tok_xxxxxxxx", card_token: dummy_card[:id]}
      expect(assigns(:card).customer_token).to eq(dummy_card[:customer])
    end


  end

  context 'not log in'do

  end
end
