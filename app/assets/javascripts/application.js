function addRedactItem() {
  str = "<li><input id='redact_redact_array_' name='redact[redact_array][]' type='text' /></li>";
  $('#redact_items > li:last').after(str);
}
