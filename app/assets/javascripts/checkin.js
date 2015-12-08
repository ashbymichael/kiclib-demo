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
        $('#ci_book_div').prepend(generateBookList(data));
      } else if(data.id === undefined) {
        $('#ci_book_div').prepend("<span class='red'>" +
                                  data.message + "</span>");
        $('#ci_book_id_field').val('');
      } else {
        $('#ci_book_div').prepend(data.id + " | " + data.title);
        $('#ci_book_id_field').val(data.id);
      }
    });
  });


});
