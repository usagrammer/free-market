class CardsController < ApplicationController
  before_action :alreday_registered?, except: [:show, :destroy]

  def new
    @card = Card.new

    now_year = Time.current.year        ## 現在の年を取得
    @exp_years = []                     ## これを年の選択肢として使用
    6.times do |i|                      ## 5回繰り返す。iは繰り返す毎に1増える
      year = now_year + i               ## 2020,2021,2022..といった値を作る
      @exp_years << [year % 100, year]  ## [20, 2020]といった配列を作成して@exp_yearsに入れる
    end
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.create(  ## 顧客の作成
    email: current_user.email,
    card: params[:payjp_token]
    )
    card = current_user.build_card(card_token: params[:card_token], customer_token: customer.id)
    if card.save!
      redirect_to card_path(current_user), notice: "カードの登録が完了しました。"
    else
      redirect_to new_card_path, alert: "カードの登録に失敗しました。"
    end

  end

  private

  def alreday_registered?
    redirect_to card_path(current_user), alert: "既にカードを登録済みです。" if current_user.card
  end

end
