document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //カテゴリのフォームが無いなら以降実行しない。

  function buildCategoryForm(categories) { // 子孫カテゴリのフォームを組み立てる
    let options = "";
    categories.forEach(function (category) { // カテゴリを一つずつ渡してoptionタグを一つずつ組み立てていく。
      options += `
                  <option value="${category.id}">${category.name}</option>
                 `;
    });

    const html = `
                  <select required="required" class="select-category" id="parent-category" name="item[category_id]">
                    <option value="">---</option>
                    ${options}
                  </select>
                 `;
    return html;
  }
  /////////buildCategoryForm()ここまで/////////

  $(".input-field-main").on("change", ".select-category", function () { //カテゴリが選択された時
    const category_id = $(this).val(); // 選択されたカテゴリのidを取得
    var changed_form = $(this); // ajax後でもthisが使えるようにするため
    $.ajax({
        url: "/api/categories",
        type: "GET",
        data: {
          category_id: category_id
        },
        dataType: 'json',
      }).done(function (categories) {
        if (categories.length == 0) return false; // categoriesが空 = 選択されたのが孫カテゴリなら何もせず終了
        changed_form.nextAll(".select-category").remove(); // 重複して表示させないために変更されたフォームより後ろのフォームを削除
        const html = buildCategoryForm(categories); // カテゴリのフォームを組み立てる
        $(".select-category:last").after(html); // 組み立てたフォームを表示
      })
      .fail(function () {
        alert('error');
      })
  });
});
