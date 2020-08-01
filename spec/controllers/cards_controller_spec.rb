require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  let(:card_token) { FactoryBot.create(:card_token, user: user ) }
  let(:dummy_card) {DummyData::PayjpCard.data}

  context 'log in' do
    before do
      login user

      payjp_customer_mock = double("Payjp::Customer")
      payjp_cards = [DummyData::PayjpCard.data]
      allow(Payjp::Customer).to receive(:retrieve).and_return(payjp_customer_mock)
      allow(payjp_customer_mock).to receive(:cards).and_return(payjp_cards)

      get :index
    end

    it '' do
      # get :new
      card = Card.get_card(card_token.customer_token)
      expect(card).to eq dummy_card
      # expect(assigns(:card)).to eq card
    end

  end

  context 'not log in'do

  end
end
