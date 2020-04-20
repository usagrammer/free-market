document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //カテゴリのフォームが無いなら以降実行しない。
  $(".input-field-main").on("change", ".select-category", function () { //カテゴリが選択された時
  });
});
