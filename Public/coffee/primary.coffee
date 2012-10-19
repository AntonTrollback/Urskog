
window.app = {}

MBP.hideUrlBarOnLoad()
MBP.scaleFix()

# Navigation
# ==============================

showSubnav = ->
  if !Modernizr.touch
    $('.subnav').addClass('is-visible')

hideSubnav = ->
  if !Modernizr.touch
    $('.subnav').removeClass('is-visible')

# Product pages
# ==============================

$ ->
  # Product images is one size fit all
  # Zoom displays same image but at max size  
  $('.product-image img').okzoom ->
    width: 200
    height: 200
    round: true
    background: "#fff"
    backgroundRepeat: "no-repeat"
    shadow: "0 0 6px rgba(0,0,0,.4)"
    border: "1px solid #444"

