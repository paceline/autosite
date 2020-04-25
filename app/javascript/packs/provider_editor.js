$(document).ready(function() {

  // Render edit form in target div
  $('a.provider-edit-link').on('ajax:success', function(event) {
    [data, status, xhr] = event.detail;
    $('#provider-edit').html(data.provider);
  });

})
