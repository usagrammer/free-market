document.addEventListener('turbolinks:load', function () {

  if (!$('#item_form')[0]) return false; //商品出品・編集ページではないなら以降実行しない。

  function newFileField(index) { //新規画像投稿用のfile_fieldを作成しappendする。
    const html = `
               <input accept="image/*" class="new-item-image" style="display: block;" data-index="${index}" type="file" name="item[images_attributes][${index}][src]" id="item_images_attributes_${index}_src">
               `;
    return html;
  }
  /////////newFileField()ここまで/////////

  ///////////////////////////////////////////////////////////////
  /////////画像の投稿ボタン（グレーのブロック）をクリックした時。/////////
  ///////////////////////////////////////////////////////////////
  $("#select-image-button").on("click", function () {
    const file_field = $(".new-item-image:last"); // 新規画像投稿用のfile_fieldのを取得する。
    file_field.trigger("click"); // file_fieldをクリックさせる。
  });
  /////////画像の投稿ボタン（グレーのブロック）をクリックした時ここまで/////////

  /////////////////////////////////////////////
  /////////file_fieldが変化した時/////////
  ////////////////////////////////////////////

  $("#image-file-fields").on("change", `input[type="file"]`, function (e) { //新しく画像が選択された、もしくは変更しようとしたが何も選択しなかった時
    const file = e.target.files[0];
    const blob_url = window.URL.createObjectURL(file); //選択された画像をblob url形式に変換する。
    let index = $(this).data("index");
    index += 1;
    const file_field_html = newFileField(index);
    $("#image-file-fields").append(file_field_html);
    const preview_html = `<img class="item-image new" src="${blob_url}" width="20%">`;
    $("#select-image-button").before(preview_html);
  });
  /////////file_fieldが変化した時ここまで/////////

});
