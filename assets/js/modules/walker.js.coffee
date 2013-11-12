app.walker =

  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @steps = @el.find(".js-step")
    @backward = @el.find(".js-prev")
    @forward = @el.find(".js-next")
    @binds()

  binds: ->
    that = this

    @backward.on "click", (e) ->
      e.preventDefault()
      that.moveBackward()

    @forward.on "click", (e) ->
      e.preventDefault()
      that.moveForward()


  getIndex: (item) ->
    @steps.index($(item[0]))

  moveBackward: ->
    target = @steps.not(".u-isHidden").prev(".js-step")
    @moveTo(@getIndex(target))

  moveForward: ->
    target = @steps.not(".u-isHidden").next(".js-step")
    @moveTo(@getIndex(target))

  moveTo: (index) ->
    @steps.not("u-isHidden").addClass("u-isHidden")
    $(@steps[index]).removeClass("u-isHidden")
    #@updateNavigation(index)

  #updateNavigation: (current) ->
  #  @prevButton.prepareTransition().removeClass("is-disabled")
  #  @nextButton.prepareTransition().removeClass("is-disabled")
  #
  #  if current + 1 == 1
  #    @prevButton.prepareTransition().addClass("is-disabled")
  #  if current + 1 == @steps.length
  #    @nextButton.prepareTransition().addClass("is-disabled")
