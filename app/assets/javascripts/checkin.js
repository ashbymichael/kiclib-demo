$(document).ready(function() {
  console.log('checkin ready!');

  $('#ci_checkin_book_form').submit(function(e){
    e.preventDefault();
    var req = $.ajax({
      type: 'post',
      url: '/find_book',
      dataType: 'json',
      data: { book: $('#ci_book_input').val() }
    });
    req.success(function(data) {
      console.log(data);

      $('#ci_book_input').val('');
      if (Array.isArray(data)) {
        $('#ci_book_div').html(generateCheckedOutBookList(data));
      } else if(data.id === undefined) {
        $('#ci_book_div').html("<span class='red'>" +
                                  data.message + "</span>");
        $('#ci_book_id_field').val('');
      } else {
        if(data.student_id !== null) {
          $('#ci_book_div').html(data.id + " | " + data.title);
          $('#ci_book_id_field').val(data.id);
        } else {
          $('#ci_book_div').html(data.id + " | " + data.title +
                                 " is not checked out.");
          $('#ci_book_id_field').val('');
        }
      }
    });
  });
});

var generateCheckedOutBookList = function(data) {
  var result = "Please select a book: <ul class='red'>";
  for (var i = 0; i < data.length; i++) {
    if(data[i].student_id !== null) {
      result += ("<li><a href='#' data-book=" + data[i].id + ">" + data[i].id +
                 " | " + data[i].title + "</a></li>");
    } else {
      result += ("<li>" + data[i].id + " | " + data[i].title +
                 " is not checked out." + "</li>");
    }
  }
  result += "</ul>";
  return result;
}