window.app = {}

# Init plugins from HTML5 Boilerplate Mobile
MBP.scaleFix()
MBP.preventZoom()

jQuery ->

  # Init components
  app.validator.init($('.v-form'))
  app.moveto.init($('.js-moveTo'))
  app.tabbed.init($('.js-tabbed'))
  app.shop.init($('.js-shop'))
  app.checkout.init($('#payment-form'))


  if window.location.hash is "#dev"
    inputs = $('input[data-dev]')
    for input in inputs
      $(input).val($(input).data('dev'))