// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$( document ).ready(function(){
  $(".button-collapse").sideNav({
    edge: "right",
  });

  $(".datepicker").pickadate({
    selectMonths: true,
    selectYears: 5
  });

  var endDate = new Date();
  var startDate = new Date();
  var dailyPrice = (parseInt($("#cart_price").text().replace("$", "")));

  $("#start").on("change", function(){
    var startMonth = getMonthFromString(($(this).val()).replace(/,/g, "").split(" ")[1]);
     startDate = new Date(($(this).val()).replace(/,/g, "").split(" ")[2], startMonth, ($(this).val()).replace(/,/g, "").split(" ")[0]);
    var days = Math.ceil((difference(endDate, startDate)));
    var totalPrice = dailyPrice * days;
    if (totalPrice > 0 ) {
      $(".cart_total").text("Total Price: $" + totalPrice);
    }
  });

  $("#end").on("change", function(){
    var endMonth = getMonthFromString(($(this).val()).replace(/,/g, "").split(" ")[1]);
     endDate = new Date(($(this).val()).replace(/,/g, "").split(" ")[2], endMonth, ($(this).val()).replace(/,/g, "").split(" ")[0]);
    var days = Math.ceil((difference(endDate, startDate)));
    var totalPrice = dailyPrice * days;
    if (totalPrice > 0 ) {
      $(".cart_total").text("Total Price: $" + totalPrice);
    }
  });

  function getMonthFromString(mon){
    return new Date(Date.parse(mon +" 1, 2016")).getMonth();
  }

  function difference(start, end) {
    return (start - end) / 24 / 60 / 60 / 1000;
  }
});

$(document).ready(function() {
   $("select").material_select();
 });
