app.moveto =
  init: ($element) ->
    @el = $element
    @movers = $element
    @breakpoint = 767
    @eventListeners()
    @staticWidth = window.staticWidth
    that = this

    # Run on load
    width = if @staticWidth then @staticWidth else window.innerWidth
    that.testSize(width)



  eventListeners: ->
    that = this

    $(window).resize ->
      that.testSize(window.innerWidth)


  testSize: (width) ->
    if width >= @breakpoint && (@currentViewport == "narrow" || !@currentViewport?)
      @viewpoitAction("wide")
    else if width < @breakpoint && (@currentViewport == "wide" || !@currentViewport?)
      @viewpoitAction("narrow")


  viewpoitAction: (size) ->
    @currentViewport = size
    @movers.each ->
      $this = $(this)
      $this.appendTo($this.attr("data-target#{size}"))