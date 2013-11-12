#= require lib/jquery.js
#= require lib/jquery.validation.js
#= require lib/jquery.payment.js
#  require lib/jquery.reel.js
#= require lib/mbp.js
#= require modules/eventlistener.js
#= require modules/moveto.js
#= require modules/tabbed.js
#= require modules/walker.js
#= require modules/validator.js
#= require modules/shop.js
#= require modules/checkout.js
#  require modules/rotate.js

MBP.scaleFix()
MBP.preventZoom()
MBP.enableActive()

jQuery ->

  app.validator.init($(".v-form"))
  app.moveto.init($(".js-moveTo"))
  app.tabbed.init($(".js-tabbed"))
  app.shop.init($(".js-shop"))
  app.walker.init($(".js-walker"))
  app.checkout.init($("#payment-form"))


  $("input[readonly]").on "click", ->
    $(this).select()

  # dev helper
  if window.location.hash is "#dev"
    inputs = $("input[data-dev]")
    for input in inputs
      $(input).val($(input).data("dev"))
