$(document).ready(function() {
  console.log('ready');
  $('#co_book_form').submit(function(e){
    e.preventDefault();
    var req = $.ajax({
      type: 'get',
      url: '/books/' + $('#co_book_input').val(),
      dataType: 'json'
    });
    req.success(function(data) {
      console.log(data);
      $('#co_book_input').val('');
      $('#co_book_div').html(data.title);
      $('#co_book_id_field').val(data.id);
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
      console.log(data);
      $('#co_student_input').val('');
      if (Array.isArray(data)) {
        $('#co_student_div').html(generateList(data));
      } else {
        $('#co_student_div').html(data.name + " | " + data.contact);
        $('#co_student_id_field').val(data.id);
      }
    });
  });

  $('#co_student_div').on("click", "a", function(e){
    e.preventDefault();
    console.log($(this).attr('data-student'));
    var req = $.ajax({
      type: 'get',
      url: '/students/' + $(this).attr('data-student'),
      dataType: 'json'
    });
    req.success(function(data){
      console.log(data);
      $('#co_student_input').val('');
      $('#co_student_div').html(data.name + " | " + data.contact);
      $('#co_student_id_field').val(data.id);
    });
  });
});

var generateList = function(data) {
  var result = "<ul>";
  for (var i = 0; i < data.length; i++) {
    result += ("<li><a href='#' data-student=" + data[i].id + ">" +
               data[i].name + "</a></li>");
  }
  result += "</ul>";
  return result;
}
