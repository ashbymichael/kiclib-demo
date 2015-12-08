$(document).ready(function() {
  console.log('checkin ready!');

  $('#ci_checkin_form').submit(function(e){
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
      $('#ci_book_div').prepend(data.id + " | " + data.title);
      $('#ci_book_id_field').val(data.id);

    });
  });
});
