document.addEventListener('turbolinks:load', function () {
    var elements = document.querySelectorAll(".delivery-row")
    if (elements !== null) {
        var hiddenField = document.getElementById('order_delivery_id')
        var notificationDiv = document.getElementById('notifications')
        elements.forEach(function (element) {
            element.addEventListener('click', function () {
                hiddenField.value = this.dataset.delivery
                notificationDiv.innerHTML = `Selected method: ${this.children[0].textContent}`
            })
        });
    }
    tippy('[data-toggle="tooltip"]');
})