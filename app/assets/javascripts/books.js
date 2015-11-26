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
      type: 'get',
      url: '/students/' + $('#co_student_input').val(),
      dataType: 'json'
    });

    req.success(function(data){
      console.log(data);
      $('#co_student_input').val('');
      $('#co_student_div').html(data.name + " | " + data.contact);
      $('#co_student_id_field').val(data.id);
    });
  });

  // $('#checkout_button').click(function(e){
  //   e.preventDefault();
  //   var req = $.ajax({
  //     type: 'patch',
  //     url: '/books/' + $.trim($('#book_params').text()),
  //     dataType: 'html',
  //     data: { student: $.trim($('#student_params').text()) }
  //   });
  // });

});
