class Api::LikesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_log_in

  def switch
    item = Item.find(params[:item_id])

    ## 既にイイね済みか確認
    unless like = item.likes.find_by(user_id: current_user.id)
      ## find_byの結果がnull = まだイイねしていない
      item.liked_users << current_user
      result = "added"
    else
      ## find_byの結果がnullではない = イイね済み
      like.destroy!
      result = "deleted"
    end

    render json: {result: result}
  end

  def check_log_in
    ## ログインしていない場合はjsonで"not_logined"と返して終了する
    render json: { result: "not_logined" } unless current_user
  end

end
