document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //カテゴリのフォームが無いなら以降実行しない。
  $(".input-field-main").on("change", ".select-category", function () { //カテゴリが選択された時
    const category_id = $(this).val(); // 選択されたカテゴリのidを取得
    $.ajax({
        url: "/api/categories",
        type: "GET",
        data: {
          category_id: category_id
        },
        dataType: 'json',
      }).done(function (categories) {
      }.bind(this)) //  -----ここにbind(this)を追加するとajax後でもthisが維持される-----
      .fail(function () {
        alert('error');
      })
  });
});
