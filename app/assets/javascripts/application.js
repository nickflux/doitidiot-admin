// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require twitter/bootstrap
//= require_tree .


function addRedactItem() {
  str = "<li><input id='redact_redact_array_' name='redact[redact_array][]' type='text' /></li>";
  $('#redact_items > li:last').after(str);
}
