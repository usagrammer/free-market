require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  let(:dummy_card) { DummyData::PayjpCard.data }
  let(:card_token) { FactoryBot.build(:card_token, card_token: dummy_card[:id], customer_token: dummy_card[:customer], user: nil) }

  context 'log in' do

    before do
      login user

      payjp_customer_mock = double("Payjp::Customer")
      payjp_cards = [ dummy_card ]
      allow(Payjp::Customer).to receive(:retrieve).and_return(payjp_customer_mock)
      allow(payjp_customer_mock).to receive(:cards).and_return(payjp_cards)

      allow(Payjp::Customer).to receive(:create).and_return(payjp_customer_mock)
      allow(payjp_customer_mock).to receive(:id).and_return(payjp_cards.first[:customer])
    end

    it '#index' do
      card_token.user = user
      card_token.save
      get :index
      expect(assigns(:card)[:customer]).to eq(dummy_card[:customer])
    end

    it '#create' do
      post :create, params: {payjp_token: "tok_xxxxxxxx", card_token: dummy_card[:id]}
      expect(assigns(:card).customer_token).to eq(dummy_card[:customer])
    end


  end

  context 'not log in'do

  end
end
