document.addEventListener('turbolinks:load', function () {
    var elements = document.querySelectorAll(".delivery-row")
    if (elements !== null) {
        var hiddenField = document.getElementById('order_delivery_id')
        elements.forEach(function (element) {
            element.addEventListener('click', function () {
                hiddenField.value = this.dataset.delivery
            })
        });
    }
    tippy('[data-toggle="tooltip"]');
})