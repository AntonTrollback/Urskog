
# Primary javascript
# =================================

window.Something = {};


# Document ready
# =================================

$ ->

  $('.product-image img').okzoom({
    width: 200,
    height: 200,
    round: true,
    background: "#fff",
    backgroundRepeat: "no-repeat",
    shadow: "0 0 6px rgba(0,0,0,.4)",
    border: "1px solid #444"
  });
