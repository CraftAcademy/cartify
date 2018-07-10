document.addEventListener('turbolinks:load', function () {
    var elements = document.querySelectorAll(".delivery-row")
    if (elements !== null) {
        var hiddenField = document.getElementById('order_delivery_id')
        elements.forEach(function (element) {
            element.addEventListener('click', function () {
                hiddenField.value = this.dataset.delivery
                document.getElementById('notifications').innerHTML = `Selected method: ${this.children[0].textContent}`
                document.querySelector("input[name='commit']").disabled = false
            })
        });
    }
    tippy('[data-toggle="tooltip"]');
})