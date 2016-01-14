$(document).ready(function() {
  $('#co_book_form').submit(function(e){
    e.preventDefault();
    var req = $.ajax({
      type: 'post',
      url: '/find_book',
      dataType: 'json',
      data: { book: $('#co_book_input').val() }
    });
    req.success(function(data) {
      $('#co_book_input').val('');
      if (Array.isArray(data)) {
        $('#co_book_div').html(generateBookList(data));
        $('#co_book_div').css("background-color", "rgba(242, 180, 180, 0.75)");
      } else if (data.book.id === undefined){
        $('#co_book_div').html("<span class='red'>" + data.message + "</span>");
        $('#co_book_id_field').val('');
      } else {
        $('#co_book_div').html("<span class='green'>" + data.book.title + "</span>");
        $('#co_book_id_field').val(data.book.id);
      }
    });
  });

  $('#co_student_form').submit(function(e){
    e.preventDefault();
    var req = $.ajax({
      type: 'post',
      url: '/find_student',
      dataType: 'json',
      data: { student: $('#co_student_input').val() }
    });

    req.success(function(data){
      $('#co_student_input').val('');
      if (Array.isArray(data)) {
        $('#co_student_div').css('background-color', "rgba(242, 180, 180, 0.75)")
        $('#co_student_div').html(generateStudentList(data));
      } else if (data.id === undefined) {
        $('#co_student_div').html("<span class='red'>" + data.message
                                  + "</span>");
        $('#co_student_id_field').val(data.id);
      } else {
        $('#co_student_div').html("<span class='green'>" + data.name + "</span>");
        $('#co_student_id_field').val(data.id);
      }
    });
  });

  $('#co_book_div').on("click", "a", function(e){
    e.preventDefault();
    var req = $.ajax({
      type: 'get',
      url: '/books/' + $(this).attr('data-book'),
      dataType: 'json'
    });
    req.success(function(data){
      $('#co_book_input').val('');
      $('#co_book_div').css("background-color", "inherit");
      $('#co_book_div').html("<span class='green'>" + data.title + "</span>");
      $('#co_book_id_field').val(data.id);
    });
  });

  $('#co_student_div').on("click", "a", function(e){
    e.preventDefault();
    var req = $.ajax({
      type: 'get',
      url: '/students/' + $(this).attr('data-student'),
      dataType: 'json'
    });
    req.success(function(data){
      $('#co_student_input').val('');
      $('#co_student_div').css('background-color', 'inherit')
      $('#co_student_div').html("<span class='green'>" + data.name + "</span>");
      $('#co_student_id_field').val(data.id);
    });
  });
});

var generateStudentList = function(data) {
  var result = "<strong>Please select a student:</strong> <ul class='red'>";
  for (var i = 0; i < data.length; i++) {
    result += ("<li><a href='#' data-student=" + data[i].id + ">" +
        data[i].sid + ' | ' + data[i].name + "</a></li>");
  }
  result += "</ul>";
  return result;
};

var generateBookList = function(data) {
  var result = "<strong>Please select a book:</strong> <ul class='red'>";
  for (var i = 0; i < data.length; i++) {
    result += ("<li><a href='#' data-book=" + data[i].id + ">" +
        data[i].number + " | " + data[i].title + "</a></li>");
  }
  result += "</ul>";
  return result;
}












// .
