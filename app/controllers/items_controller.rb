class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy, :purchase_confirmation, :purchase]
  before_action :user_is_not_seller, only: [:edit, :update, :destroy]
  before_action :user_is_seller, only: [:purchase_confirmation, :purchase]
  before_action :sold_item, only: [:edit, :update, :destroy, :purchase_confirmation, :purchase]

  def index
    ladies_category = Category.find_by(name: "レディース")
    mens_category = Category.find_by(name: "メンズ")
    kids_category = Category.find_by(name: "ベビー・キッズ")

    ladies_items = Item.search_by_categories(ladies_category.subtree).new_items
    mens_items = Item.search_by_categories(mens_category.subtree).new_items
    kids_items = Item.search_by_categories(kids_category.subtree).new_items

    @new_items_arrays = [
       {category: ladies_category, items: ladies_items},
       {category: mens_category, items: mens_items},
       {category: kids_category, items: kids_items}
      ]
  end

  def show

  end

  def new
    @item = Item.new
    @item.images.build
    render layout: 'no_menu' # レイアウトファイルを指定
  end

  def create
    @item = Item.new(item_params)

    params[:item][:item_images].each_with_index do |image|
      @item.item_images.attach(image)
    end

    if @item.save
      redirect_to root_path, notice: "出品に成功しました"
    else
      redirect_to new_item_path, alert: @item.errors.full_messages
    end
  end

  def edit
    @item = Item.find(params[:id])
    @item.images.build
    render layout: 'no_menu'  # レイアウトファイル指定
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)

      params[:delete_image_storage_ids]&.each do |id|
        @item.item_images[id.to_i].purge
      end

      params[:changed_images].each do |image|
        @item.item_images.attach(image)
      end

      redirect_to root_path, notice: "出品に成功しました"
    else
      redirect_to edit_item_path(@item), alert: @item.errors.full_messages  ## ここを変更
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: "商品の削除が完了しました。"
    else
      redirect_to edit_item_path(@item), alert: "商品が削除できませんでした。"
    end
  end

  def purchase_confirmation
    @card = Card.get_card(current_user.card.customer_token) if current_user.card
    render layout: 'no_menu' # レイアウトファイル指定
  end

  def purchase
    redirect_to cards_path, alert: "クレジットカードを登録してください" and return unless current_user.card.present?
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      customer: customer_token, # 顧客、もしくはカードのトークン
      currency: 'jpy'  # 通貨の種類
    )
    @item.update(deal: "売り切れ")
    redirect_to item_path(@item), notice: "商品を購入しました"
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :detail,
      :condition,
      :delivery_fee_payer,
      :delivery_method,
      :delivery_days,
      :prefecture_id,
      :category_id,
      images_attributes: [:src, :id, :_destroy]
      ).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def user_is_not_seller
    redirect_to root_path, alert: "あなたは出品者ではありません" unless @item.seller_id == current_user.id
  end

  def user_is_seller
    redirect_to root_path, alert: "自分で出品した商品は購入できません" if @item.seller_id == current_user.id
  end

  def sold_item
    redirect_to root_path, alert: "売り切れです" if @item.deal != "販売中"
  end

end
