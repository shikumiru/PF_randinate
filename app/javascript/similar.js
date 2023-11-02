$(document).ready(function() {
  $("#vision-api").click(function(e) {
    e.preventDefault(); // リンクのデフォルトの遷移をキャンセル
    var url = $(this).attr("href"); // リンク先のURLを取得
    // Ajaxリクエストを送信
    $.ajax({
      url: "/coordinates/similar",
      type: "GET",
      dataType: "script",
      success: function(data) {
        // レスポンスのデータを表示する要素を取得
        $("#similar").html(data);
      },
    });
  });
});