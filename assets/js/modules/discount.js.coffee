app.discount =

  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @controls = @el.find(".js-discountControl")
    @binds()

  binds: ->
    that = this
    console.log('lol')

    @el.on "click", ".js-showControl", (e) ->
      e.preventDefault()
      that.showControl($(this))


  showControl: ($button) ->
    @controls
      .not(":not(.u-isHidden)")
        .first()
          .removeClass("u-isHidden")
          .find("input")
            .focus()
    unless @controls.is(".u-isHidden")
      $button.hide()

  getDiscountStatus: ->

  errorState: ->

  successState: ->

  clearState: ->

  setControlButtonText: ->
