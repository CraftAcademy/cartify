// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require rails-ujs
//= require turbolinks
//= require popper
//= require bootstrap
//= require jquery.mask
//= require tippy
//= require_tree .

function reload() {
    if ((typeof Turbolinks === 'undefined' || Turbolinks === null)) {
        location.reload;
    } else {
        Turbolinks.visit(window.location, { action: 'replace' })
        Turbolinks.clearCache();
        Turbolinks.dispatch("turbolinks:load");
    }

}


function redirectTo(url) {
    if ((typeof Turbolinks === 'undefined' || Turbolinks === null)) {
        window.location = url;
    } else {
        Turbolinks.visit(url, { action: 'replace' })
        Turbolinks.clearCache();
        Turbolinks.dispatch("turbolinks:load");
    }
}
function clearNotifications() {
    var noticeDiv = document.getElementById('notifications')
    if (noticeDiv.length !== 0) {
        noticeDiv.innerHTML = ''
    }
}

document.addEventListener('turbolinks:load', function () {
    tippy('[title]')
})
