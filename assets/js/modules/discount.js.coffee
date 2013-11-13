app.discount =

  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @controls = @el.find(".js-discountControl")
    @binds()

  binds: ->
    that = this

    @el.on "click", ".js-showControl", (e) ->
      e.preventDefault()
      that.showControl($(this))

    @controls.on "click", "button", (e) ->
      e.preventDefault()
      console.log("ACTION")
      $this = $(this)

      $input = $this.siblings("input")
      state = $input.data("state")
      that.getDiscountStatus($this, $input)

    # Clear states on input focus
    @controls.on "focus", "input", (e) ->
      e.preventDefault()
      $button = $(this).siblings("button")
      that.clearState($button, $(this))

    # Disable enter key
    @controls.on "keypress", "input", (e) ->
      if e.which == 13
        false

  showControl: ($button) ->
    @controls
      .not(":not(.u-isHidden)")
        .first()
          .removeClass("u-isHidden")
          .find("input")
            .focus()
    unless @controls.is(".u-isHidden")
      $button.hide()

  getDiscountStatus: ($button, $input) ->
    that = this
    value = $input.val()

    if @validateDiscount(value)
      @loadingState($button, $input)
      setTimeout (->
        if window.location.hash is "#valid"
          that.successState($button, $input)
        else
          that.errorState($button, $input)
      ), 1500
    else
      @errorState($button, $input, "Invalid")



  validateDiscount: (value) ->
    value.length == 10 and /^[A-Za-z0-9]+$/.test(value)

  loadingState: ($button, $input) ->
    @clearState($button, $input)
    $button.text("Loading…").attr("disabled", true)
    $input.attr("disabled", true)

  errorState: ($button, $input, message = "Used or invalid") ->
    @clearState($button, $input)
    $button.text(message)
    $input.addClass("is-invalid")

  successState: ($button, $input) ->
    @clearState($button, $input)
    $button.text("Saved").attr("disabled", true)
    $input.addClass("is-correct").attr("disabled", true)

  clearState: ($button, $input) ->
    $button.text("Save").attr("disabled", false)
    $input
      .removeClass("is-invalid")
      .removeClass("is-correct")
      .attr("disabled", false)