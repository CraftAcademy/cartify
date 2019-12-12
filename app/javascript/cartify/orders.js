document.addEventListener('turbolinks:load', function () {
    var elements = document.querySelectorAll(".clickable-row")
    if (elements !== null) {
        elements.forEach(function (element) {
            element.addEventListener('click', function (event) {
                redirectTo(this.dataset.href)
            })
        });
    }
    tippy('[data-toggle="tooltip"]');
})