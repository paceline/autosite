// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


$(document).ready(function() {

  // Add flash notice on success
  $('form[data-remote="true"]').on('ajax:success', function(event) {
    [data, status, xhr] = event.detail;
    $('#notices').html(`<p class="notice">${data}</p>`);
    rollUpNotice();
  });

  // Roll up notices after a few seconds
  rollUpNotice();

})

function rollUpNotice() {
  $('p.notice').delay(5000).slideUp("slow")
}
