app.walker =

  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @steps = @el.find(".js-step")
    @validatedWalker = @el.is('.js-validate')
    if @validatedWalker
      @allowedToWalk = false
    @binds()

  binds: ->
    that = this

    @el.find(".js-prev").on "click", (e) ->
      e.preventDefault()
      that.walkBackward()

    @el.find(".js-next").on "click", (e) ->
      e.preventDefault()
      that.walkForward()

    app.eventListener.add "validator", "validate", (data) ->
      if data.valid
        that.allowedToWalk = true
      else
        that.allowedToWalk = false

  getIndex: (item) ->
    @steps.index($(item[0]))

  walkBackward: ->
    target = @steps.not(".u-isHidden").prev(".js-step")
    @walk(@getIndex(target), "backward")

  walkForward: ->
    target = @steps.not(".u-isHidden").next(".js-step")
    @walk(@getIndex(target), "forward")

  walk: (index, direction) ->
    if @validatedWalker and direction == "forward"
      app.eventListener.fire "walker", "wishToWalk", null

    if @allowedToWalk or direction == "backward"
      @steps.not("u-isHidden").addClass("u-isHidden")
      $target = $(@steps[index]).removeClass("u-isHidden")

      data =
        id: $target.attr("id")
        direction: direction
      app.eventListener.fire "walker", "walked", data


