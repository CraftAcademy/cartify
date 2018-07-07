document.addEventListener('turbolinks:load', function() {
    $(".clickable-row").click(function() {
        debugger;
        window.location = $(this).data("href");
    });

    document.addEventListener('click', function(){

    })
    tippy('[data-toggle="tooltip"]');
})