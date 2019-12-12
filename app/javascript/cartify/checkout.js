document.addEventListener('turbolinks:load', function() {
  $(".clickable-step").click(function() {
    window.location = $(this).data("href");
  });

  $(".clickable-step").css( 'cursor', 'pointer' );

  $( "#use_billing" ).click(function() {
    $("div.col-md-5.col-md-offset-1").toggle("slow");
  });
});
