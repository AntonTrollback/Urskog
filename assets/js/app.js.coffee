#= require lib/jquery.js
#= require lib/jquery.validation.js
#= require lib/jquery.payment.js
#  require lib/jquery.reel.js
#= require lib/mbp.js
#= require moveto.js
#= require tabbed.js
#= require validator.js
#= require shop.js
#= require checkout.js
#  require rotate.js

MBP.scaleFix()
MBP.preventZoom()
MBP.enableActive()

jQuery ->

  app.validator.init($('.v-form'))
  app.moveto.init($('.js-moveTo'))
  app.tabbed.init($('.js-tabbed'))
  app.shop.init($('.js-shop'))
  app.checkout.init($('#payment-form'))

  # dev helper
  if window.location.hash is "#dev"
    inputs = $('input[data-dev]')
    for input in inputs
      $(input).val($(input).data('dev'))