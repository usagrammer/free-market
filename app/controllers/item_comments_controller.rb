class ItemCommentsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    @item_comment = @item.item_comments.new(item_comment_params)
    if @item_comment.save
      html = render_to_string partial: "/items/item_comment.html.haml", locals: {item_comment: @item_comment}
      ActionCable.server.broadcast 'item_comment_channel', {html: html}
    else
      @item.item_comments.delete(@item_comment)
      flash.now[:alert] = @item_comment.errors.full_messages
      render template: 'items/show'
    end
  end

  private
  def item_comment_params
    params.require(:item_comment).permit(:content).merge(user_id: current_user.id)
  end

end
