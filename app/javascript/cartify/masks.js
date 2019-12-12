$(function($){
  $("#credit_card_mm_yy").mask("99/99",{placeholder:"MM/YY"});
  $("#credit_card_cvv").mask("999");
  $("#credit_card_number").mask("0000  0000  0000  0000", {placeholder: "* * * *\t* * * *\t* * * *\t* * * *"});
});

