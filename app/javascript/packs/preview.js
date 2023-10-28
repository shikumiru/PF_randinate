$(document).on("turbolinks:load", function () {
  $("#form").on("change", function (e) {
    var files = e.target.files;
    var d = new $.Deferred().resolve();
    $.each(files, function (i, file) {
      d = d.then(function () {
        return previewImage(file);
      });
    });
  });

  var previewImage = function (imageFile) {
    var reader = new FileReader();
    var img = new Image();
    var def = $.Deferred();
    reader.onload = function (e) {
      $("#image_preview").empty();
      $("#image_preview").append(img);
      img.src = e.target.result;
      def.resolve(img);
    };
    img.classList.add('preview-size');
    reader.readAsDataURL(imageFile);
    return def.promise();
  };
});