$(function(){
  "use strict";

  $("button").click(function(){
    $("img").last().animate({
      top: "-=20"
    }, 1000).animate({
      left: "-=40"
    }, 1000).animate({
      top: "+=20"
    }, 1000);
  });
  
});