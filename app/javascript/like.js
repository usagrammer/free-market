document.addEventListener("turbolinks:load", function () {
  const likeButton = document.querySelector("#item-like");

  if (!likeButton) return false; //イイねボタンがないなら以降実行しない。

  console.log("like.js");

  likeButton.addEventListener("click", function () {
    const itemId = this.dataset.itemId;
    console.log("item_id:", itemId);

    const XHR = new XMLHttpRequest();
    XHR.open("POST", `/likes`, true);
    XHR.responseType = "json";

    // ①ビューに埋め込まれているCSRF対策用のトークンを取得する
    const csrfToken = document.querySelector(`meta[name="csrf-token"]`).content

    // ②リクエストの形式を指定する
    XHR.setRequestHeader("Content-Type", "application/json");
    XHR.setRequestHeader("X-CSRF-Token", csrfToken);

    // ③パラメータとして送信するデータをjsonの形に整形する
    const sendData = JSON.stringify({
      item_id: itemId // params[:item_id]でitemIdが取り出せるようになる
    });

    // ④ajax通信を開始する（sendDataをparamsに送る）
    XHR.send(sendData);

    XHR.onload = () => {

      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
      } else {
        //ーーーーーー追加ここからーーーーー
        if (XHR.response.result == "not_logined") {
          alert("ログインしてください");
          return false
        }
        //ーーーーーー追加ここまでーーーーー

        // イイねボタンのうちハートマークを取得
        const heartMark = document.querySelector("#item-like-heart");
        // toggleメソッドでlikedクラスを追加/削除する
        heartMark.classList.toggle('liked');

        // イイねの数 「.textContent」時点では文字列になっているためNumber()で数値に変換する
        let likes_count = Number(document.querySelector("#likes-count").textContent);
        if (XHR.response.result == "added") {
          // ajaxのレスポンスが"added"だった場合、イイねのカウントを1増やす
          document.querySelector("#likes-count").textContent = likes_count + 1;
        } else if (XHR.response.result == "deleted") {
          // ajaxのレスポンスが"deleted"だった場合、イイねのカウントを1増やす
          document.querySelector("#likes-count").textContent = likes_count - 1;
        }

      }
    };

  });

});
