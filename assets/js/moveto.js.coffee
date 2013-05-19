app.moveto =
  init: ($element) ->
    @el = $element
    @movers = $element
    @breakpoint = 830
    @eventListeners()
    that = this

    # Run on load
    that.testSize($(window).width())


  eventListeners: ->
    that = this

    $(window).resize ->
      that.testSize($(window).width())


  testSize: (width) ->
    if width >= @breakpoint && !@wideViewport
      @wideViewpoitAction()
      @wideViewport = true
    else if width < @breakpoint && (@wideViewport || @wideViewport == undefined)
      @narrowViewpoitAction()
      @wideViewport = false


  wideViewpoitAction: ->
    console.log('Move up')
    @movers.each ->
      $this = $(this)
      $this.appendTo($this.attr('data-targetWide'))


  narrowViewpoitAction: ->
    console.log('Move down')
    @movers.each ->
      $this = $(this)
      $this.appendTo($this.attr('data-targetNarrow'))