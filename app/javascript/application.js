// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'jquery'
//alert("oi");
$('.message_hide_password').hide();
$(function(){
    var regExp = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,}$/ ;
  
    $('[type="text"]').on('keyup', function() {
      $('.message_hide_password').hide();
      regExp.test( $(this).val() ) ? $('.message_hide_password.success').show() : $('.message_hide_password.error').show();
    });
  
  });