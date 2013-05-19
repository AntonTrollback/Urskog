app.moveto =
  init: ($element) ->
    @el = $element
    @breakpoint = 830
    @eventListeners()

    that = this

    # Run on load
    @el.each (i) ->
      that.testSize($(this), $(window).width())


  eventListeners: ->
    that = this

    $(window).resize ->
      that.el.each (i) ->
        that.testSize($(this), $(window).width())


  testSize: ($el, width) ->
    if width > @breakpoint
      @wideViewpoitAction($el)
    else
      @narrowViewpoitAction($el)


  wideViewpoitAction: ($el)->
    targetWideSelector = $el.attr('data-targetWide')
    $el.appendTo(targetWideSelector)


  narrowViewpoitAction: ($el)->
    targetNarrowSelector = $el.attr('data-targetNarrow')
    $el.appendTo(targetNarrowSelector)