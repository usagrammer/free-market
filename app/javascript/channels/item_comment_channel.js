import consumer from "./consumer"

consumer.subscriptions.create("ItemCommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("hoge");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.table(data);
    // Called when there's incoming data on the websocket for this channel
    const item_comments = document.querySelector('.item-comments');
    item_comments.insertAdjacentHTML('beforeend', data.html);
    item_comments.scrollTop = item_comments.scrollHeight;
    const form = document.querySelector('#item-comment-form');
    form.reset();
    const submitButton = document.querySelector('input[type="submit"]');
    submitButton.disabled = false;
  }
});
