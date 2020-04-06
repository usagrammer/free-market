class CardsController < ApplicationController
  def new
    @card = Card.new

    now_year = Time.current.year        ## 現在の年を取得
    @exp_years = []                     ## これを年の選択肢として使用
    6.times do |i|                      ## 5回繰り返す。iは繰り返す毎に1増える
      year = now_year + i               ## 2020,2021,2022..といった値を作る
      @exp_years << [year % 100, year]  ## [20, 2020]といった配列を作成して@exp_yearsに入れる
    end
end
