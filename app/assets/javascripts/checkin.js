$(document).ready(function() {

  $('#ci_checkin_book_form').submit(function(e){
    e.preventDefault();
    var req = $.ajax({
      type: 'post',
      url: '/find_book',
      dataType: 'json',
      data: { book: $('#ci_book_input').val() }
    });
    req.success(function(data) {

      $('#ci_book_input').val('');
      if (Array.isArray(data)) {
        $('#ci_book_div').html(generateCheckedOutBookList(data));
        $('#ci_form_div').addClass("hidden");
      } else if(data.status === 'in') {
        $('#ci_book_div').html("<span class='red'>" +
                                  data.book.title + " is not checked out.</span>");
        $('#ci_book_id_field').val('');
      } else {
        if(data.status === 'out') {
          $('#ci_book_div').html(data.book.id + " | " + data.book.title);
          $('#ci_form_div').removeClass("hidden");
          $('#ci_book_id_field').val(data.book.id);
        } else {
          $('#ci_book_div').html(data.book.id + " | " + data.book.title +
                                 " is not checked out.");
          $('#ci_book_id_field').val('');
          $('#ci_form_div').addClass("hidden");
        }
      }
    });
  });
});

var generateCheckedOutBookList = function(data) {
  var result = "Please select a book: <ul>";
  for (var i = 0; i < data.length; i++) {
    if(data[i].student_id !== null) {
      result += ("<li><a href='books/" + data[i].id + "' data-book=" +
                 data[i].id + ">" + data[i].id + " | " + data[i].title +
                 "</a></li>");
    } else {
      result += ("<li class='faded'>" + data[i].id + " | " + data[i].title +
                 " is not checked out." + "</li>");
    }
  }
  result += "</ul>";
  return result;
}
