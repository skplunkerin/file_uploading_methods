$(function(){
  var form = $('form'),
      dropdown = $('#clientside_publishing_methods'),
      old_school = $('#old_school'),
      aws = $('#aws'),
      port = $('#clientside_publishing_port'),
      btn = $('input[type=submit]')
  ;

  dropdown
  .change(function(){
    var that = $(this),
        val = that.val(),
        method_ports = {'FTP':'20','SFTP':'22','SCP':'22'} // http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
    ;
    console.log(val);
    if ( val in method_ports ){
      // Show old_school, hide aws
      old_school.removeClass('hide');
      aws.addClass('hide');
      port.val( method_ports[val] );
    } else {
      // show aws, hide old_school
      aws.removeClass('hide');
      old_school.addClass('hide');
      console.log( 'not in array' );
    }
    btn.removeAttr('disabled');
  });
});
