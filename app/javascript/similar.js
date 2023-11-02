// $(document).ready(function() {
//   $("#visionapi").click(function(e) {
//     e.preventDefault(); // リンクのデフォルトの遷移をキャンセル
//     var url = $(this).attr("href"); // リンク先のURLを取得
//     // Ajaxリクエストを送信
//     $.ajax({
//       url: "url",
//       success: function(data) {
//         // レスポンスのデータを表示する要素を取得
//         $("#similar").html(data);
//       },
//       error: function(error) {
//         console.log(error);
//       }
//     });
//   });
// });