app.rotate =
  init: ($element) ->
    @el = $element
    that = this

    # init jQuery Reel
    @el.reel(
      path: "http://urskog.com/img/360/#{that.el.data('name')}/"
      images: that.frames(119)
      vertical: true
      wheelable: false
      revolution: 1000
      preloader: 0
      brake: 1.1
      cursor: "ns-resize"
      scrollable: false
    )

  frames: (frames) ->
    every = 1
    stack = []
    i = 1

    while i <= frames
      name = [i, ".jpg"].join("")
      name = "0" + name  while name.length < 7
      stack.push name
      i += every
    stack
