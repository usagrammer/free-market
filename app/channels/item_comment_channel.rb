class ItemCommentChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "item_comment_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
