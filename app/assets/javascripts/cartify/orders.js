document.addEventListener('turbolinks:load', function () {
    var element = document.querySelector(".clickable-row")
    if (element !== null) {
        element.addEventListener('click', function () {
            window.location = $(this).data("href");
        })
    }
    tippy('[data-toggle="tooltip"]');
})