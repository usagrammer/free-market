class ItemsController < ApplicationController

  def new
    render layout: 'no_menu' # レイアウトファイルを指定
  end

  def edit
    render layout: 'no_menu' # レイアウトファイル指定
  end

  def purchase_confirmation
    render layout: 'no_menu' # レイアウトファイル指定
  end

end
