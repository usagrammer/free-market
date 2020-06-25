document.addEventListener("turbolinks:load", function () {
  return false;
  if (!$("#item_form")[0]) return false; //商品出品・編集ページではないなら以降実行しない。

  function buildImagePreview(blob_url, index) {
    //選択した画像ファイルのプレビューを表示する。
    html = `
            <div class="item-image new" data-index=${index}>
              <img src =${blob_url} class="item-image__image">
              <div class="item-image__buttons">
                <div class="item-image__buttons--edit">
                編集
                </div>
                <div class="item-image__buttons--delete">
                削除
                </div>
              </div>
            </div>
            `;
    return html;
  }
  /////////buildImagePreview()ここまで/////////

  function newFileField(index) {
    //新規画像投稿用のfile_fieldを作成する。
    const html = `
               <input accept="image/*" class="new-item-image" data-index="${index}" type="file" name="item[images_attributes][${index}][src]" id="item_images_attributes_${index}_src">
               `;
    return html;
  }
  /////////newFileField()ここまで/////////

  ///////////////////////////////////////////////////////////////
  /////////画像の投稿ボタン（グレーのブロック）をクリックした時。/////////
  ///////////////////////////////////////////////////////////////
  $("#select-image-button").on("click", function () {
    const file_field = $(".new-item-image:last"); // 新規画像投稿用のfile_fieldを取得する。
    file_field.trigger("click"); // file_fieldをクリックさせる。
  });
  /////////画像の投稿ボタン（グレーのブロック）をクリックした時ここまで/////////

  /////////////////////////////////////////////
  /////////file_fieldが変化した時/////////
  ////////////////////////////////////////////

  $("#image-file-fields").on("change", `input[type="file"]`, function (e) { //新しく画像が選択された、もしくは変更しようとしたが何も選択しなかった時
    const file = e.target.files[0];
    let index = $(this).data("index");
    if (!file) { // fileが空→編集ボタンをクリックしたが何も選択しなかった
      // 削除ボタンを起動させて終了
      const delete_button = $(`.item-image[data-index="${index}"]`).find(".item-image__buttons--delete");
      delete_button.trigger("click");
      return false;
    }
    const blob_url = window.URL.createObjectURL(file); //選択された画像をblob url形式に変換する。
    if ($(`.item-image[data-index="${index}"]`)[0]) { // プレビュー画像が表示されている→編集ボタンで画像を変更しようとしている
      // プレビュー画像の差し替えのみを行い終了
      const preview_image = $(`.item-image[data-index="${index}"]`).children("img"); // 既に表示されているプレビュー画像を取得
      preview_image.attr("src", blob_url); // プレビュー画像のsrc属性を書き換えることで画像が変わる
      return false;
    }
    // 以下は画像の新規追加処理
    const preview_html = buildImagePreview(blob_url, index); // プレビュー画像を組み立てる
    $("#select-image-button").before(preview_html); // プレビュー画像をビューに表示する
    index += 1;
    const file_field_html = newFileField(index); // 次の画像のためのfile_fieldを組み立てる
    $("#image-file-fields").append(file_field_html); // file_fieldを追加する
  });
  /////////file_fieldが変化した時ここまで/////////

  /////////////////////////////////////////////
  /////////画像の削除ボタンをクリックした時/////////
  ////////////////////////////////////////////
  $("#selected-item-images").on("click", ".item-image__buttons--delete", function (e) {
    const index = $(this).parents(".item-image").data("index"); // 何番目の画像を削除しようとしているかを取得する
    $(this).parents(".item-image").remove(); // プレビュー画像とボタンをまとめている親要素を削除する
    $(`#item_images_attributes_${index}__destroy`).prop("checked", true); // 削除のON/OFFを表すチェックボックスにチェックを入れる
    $(`#item_images_attributes_${index}_src`).remove(); // file_fieldを削除する
  });
  /////////画像の削除ボタンをクリックした時ここまで/////////

  /////////////////////////////////////////////
  /////////画像の編集ボタンをクリックした時/////////
  ////////////////////////////////////////////
  $("#selected-item-images").on("click", ".item-image__buttons--edit", function (e) {
    const index = $(this).parents(".item-image").data("index"); // 何番目の画像を編集しようとしているかを取得する
    $(`#item_images_attributes_${index}_src`).trigger("click"); // 画像に対応する編集ボタンを起動する
  });
  /////////画像の編集ボタンをクリックした時ここまで/////////
});
