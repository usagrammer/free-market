class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy], unless: :seller?

  def index
    ladies_category = Category.find(1)
    mens_category = Category.find(200)
    kids_category = Category.find(345)

    ladies_items = Item.search_by_categories(ladies_category.subtree_ids).new_items
    mens_items = Item.search_by_categories(mens_category.subtree_ids).new_items
    kids_items = Item.search_by_categories(kids_category.subtree_ids).new_items

    @new_items_arrays = [
       {category: ladies_category, items: ladies_items},
       {category: mens_category, items: mens_items},
       {category: kids_category, items: kids_items}
      ]
  end

  def new
    @item = Item.new
    @item.images.build
    render layout: 'no_menu' # レイアウトファイルを指定
  end

  def create
    @item = Item.new(item_params)
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
    render layout: 'no_menu' # レイアウトファイル指定
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

  def move_to_index
    redirect_to root_path, alert: "エラーが発生しました。"
  end

  def seller?
    return @item.seller_id == current_user.id
  end

end
