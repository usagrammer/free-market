require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  let(:dummy_google_user) { OmniAuth::AuthHash.new(DummyData::GoogleUser.data) }
  let(:sns_credential) { FactoryBot.create(:sns_credential)}
  let(:user) { sns_credential.user }

  context 'log in' do

    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth::AuthHash.new(DummyData::GoogleUser.data)
    end

    it '#index' do
      get 'google_oauth2'
      expect(session["devise.sns_auth"][:user].email).to eq dummy_google_user.info.email
      expect(session["devise.sns_auth"][:sns_credential].uid).to eq dummy_google_user.uid
    end

  end

end
