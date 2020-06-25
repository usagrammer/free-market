import {
  DirectUpload
} from "@rails/activestorage"

document.addEventListener("turbolinks:load", function () {

  var selected_index = "";

  if (!$("#item_form")[0]) return false; //商品出品・編集ページではないなら以降実行しない。

  function buildImagePreview(blob_url, index) {
    //選択した画像ファイルのプレビューを表示する。
    const html = `
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
    const file_field = $(".new-item-image"); // 新規画像投稿用のfile_fieldを取得する。
    file_field.trigger("click"); // file_fieldをクリックさせる。
  });
  /////////画像の投稿ボタン（グレーのブロック）をクリックした時ここまで/////////

  /////////////////////////////////////////////
  /////////file_fieldが変化した時/////////
  ////////////////////////////////////////////

  $("#image-file-fields").on("change", `input[type="file"]`, function (e) { //新しく画像が選択された、もしくは変更しようとしたが何も選択しなかった時
    const file = e.target.files[0];
    // debugger
    const input = e.target;
    const url = input.dataset.directUploadUrl;
    const upload = new DirectUpload(file, url);

    upload.create((error, blob) => {
      if (error) {
        // エラーハンドリングをここに書く
      } else {
        // 名前が似ているhidden inputをblob.signed_idの値とともにフォームに追加する
        // これによりblob idが通常のアップロードフローで転送される
        const hiddenField = document.createElement('input')
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("value", blob.signed_id);
        // hiddenField.setAttribute("value", blob.id);
        $(input).val('');
        // debugger
        /////////////
        //////////////////
        ////////////////////
        let index = 0;
        console.log($(".item-image:last")[0]);
        if ($(".item-image:last")[0]) {
          console.log($(".item-image:last").data("index"));
          index = $(".item-image:last").data("index") + 1;
        }
        console.log(index);
        if (!file) { // fileが空→編集ボタンをクリックしたが何も選択しなかった
          // 削除ボタンを起動させて終了
          const delete_button = $(`.item-image[data-index="${index}"]`).find(".item-image__buttons--delete");
          delete_button.trigger("click");
          return false;
        }
        const blob_url = window.URL.createObjectURL(file); //選択された画像をblob url形式に変換する。]
        console.log(selected_index);
        if (selected_index !== "") { // プレビュー画像が表示されている→編集ボタンで画像を変更しようとしている
          // プレビュー画像の差し替えのみを行い終了
          const preview_image = $(`.item-image[data-index="${selected_index}"]`).children("img"); // 既に表示されているプレビュー画像を取得
          preview_image.attr("src", blob_url); // プレビュー画像のsrc属性を書き換えることで画像が変わる
          hiddenField.name = "changed_images[]";
          document.querySelector('form').appendChild(hiddenField)
          const deleteHiddenField = document.createElement('input')
          deleteHiddenField.setAttribute("type", "hidden");
          deleteHiddenField.setAttribute("value", selected_index);
          deleteHiddenField.name = "delete_image_storage_ids[]";
          document.querySelector('form').appendChild(deleteHiddenField)
          selected_index = "";
          return false;
        }

        hiddenField.name = input.name
        document.querySelector('form').appendChild(hiddenField)
        // 以下は画像の新規追加処理
        const preview_html = buildImagePreview(blob_url, index); // プレビュー画像を組み立てる
        $("#select-image-button").before(preview_html); // プレビュー画像をビューに表示する
        index += 1;
        // const file_field_html = newFileField(index); // 次の画像のためのfile_fieldを組み立てる
        // $("#image-file-fields").append(file_field_html); // file_fieldを追加する
      }
    })
    return false;
  });
  /////////file_fieldが変化した時ここまで/////////

  /////////////////////////////////////////////
  /////////画像の削除ボタンをクリックした時/////////
  ////////////////////////////////////////////
  $("#selected-item-images").on("click", ".item-image__buttons--delete", function (e) {
    const index = $(this).parents(".item-image").data("index"); // 何番目の画像を削除しようとしているかを取得する
    const storage_id = $(this).parents(".item-image").data("storage-id");
    const deleteHiddenField = document.createElement('input')
    deleteHiddenField.setAttribute("type", "hidden");
    deleteHiddenField.setAttribute("value", storage_id);
    deleteHiddenField.name = "delete_image_storage_ids[]";
    document.querySelector('form').appendChild(deleteHiddenField)
    console.log(storage_id);
    $(this).parents(".item-image").remove(); // プレビュー画像とボタンをまとめている親要素を削除する
    $(`#item_images_attributes_${index}__destroy`).prop("checked", true); // 削除のON/OFFを表すチェックボックスにチェックを入れる
    $(`#item_images_attributes_${index}_src`).remove(); // file_fieldを削除する
  });
  /////////画像の削除ボタンをクリックした時ここまで/////////

  /////////////////////////////////////////////
  /////////画像の編集ボタンをクリックした時/////////
  ////////////////////////////////////////////
  $("#selected-item-images").on("click", ".item-image__buttons--edit", function (e) {
    selected_index = $(this).parents(".item-image").data("index"); // 何番目の画像を編集しようとしているかを取得する
    console.log(selected_index);
    $(`.new-item-image`).trigger("click"); // 画像に対応する編集ボタンを起動する
  });
  /////////画像の編集ボタンをクリックした時ここまで/////////
});
