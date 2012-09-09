
# Primary javascript
# =================================

window.nav = {}


nav.showSubnav = () ->
  $('.subnav').addClass('is-visible')

nav.hideSubnav = () ->
  $('.subnav').removeClass('is-visible')

# Document ready
# =================================

$ ->

  $('.product-image img').okzoom ->
    width: 200
    height: 200
    round: true
    background: "#fff"
    backgroundRepeat: "no-repeat"
    shadow: "0 0 6px rgba(0,0,0,.4)"
    border: "1px solid #444"


  $(".subnav-parent").hoverIntent nav.showSubnav, nav.hideSubnav
