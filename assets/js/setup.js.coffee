# Setup our main object
window.app = {}

# Init plugins from HTML5 Boilerplate Mobile
MBP.hideUrlBarOnLoad()
MBP.scaleFix()

# Document ready
jQuery ->

  # Init components
  app.shop.init($('.js-shop'))
  app.checkout.init($('#payment-form'))