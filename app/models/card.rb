class Card < ApplicationRecord
  belongs_to :user

  def self.get_card(customer_token)  ## カード情報を取得する。支払い方法ページで使用する。
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]

    customer = Payjp::Customer.retrieve(customer_token)
    card_data = customer.cards.first
  end

end
