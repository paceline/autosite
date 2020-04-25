require("jquery-ui")

$(document).ready(function() {

  // Make page list sortable
  $('#page-list ul').sortable({
    handle: ".handle",
    update: function(event, ui) {
      let ids = [];
      $('#page-list ul li').each(function() {
        ids.push($(this).attr('id').replace("page_", ""));
      });
      $.ajax({
        type: 'POST',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        url: '/manage/pages/reorder',
        data: { page_ids: ids }
      });
    }
  });

  // Render edit form in target div
  $('a.page-edit-link').on('ajax:success', function(event) {
    [data, status, xhr] = event.detail;
    $('#page-edit').html(data.page);
  });

})
