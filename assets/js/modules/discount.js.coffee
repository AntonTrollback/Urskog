app.discount =

  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @controls = @el.find(".js-discountControl")
    @currentTotal = parseInt(@el.find(".js-priceResult").text())
    @defaultTotal = @currentTotal
    @currentPercentage = 0
    @savedCodes = []
    @binds()

  binds: ->
    that = this

    @el.on "click", ".js-showControl", (e) ->
      e.preventDefault()
      that.showControl($(this))

    @controls.on "click", "button", (e) ->
      e.preventDefault()
      $this = $(this)

      $input = $this.siblings("input")
      state = $input.data("state")
      that.discountButtonAction($this, $input)

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

  discountButtonAction: ($button, $input) ->
    value = $input.val()

    if @validateDiscount(value)
      @loadingState($button, $input)
      @getDiscountStatus($button, $input, value)
    else
      @errorState($button, $input, "Invalid")

  validateDiscount: (value) ->
    that = this
    $.inArray(value, @savedCodes) == -1 and (value.length == 10 and /^[A-Za-z0-9]+$/.test(value))

  getDiscountStatus: ($button, $input, code) ->
    that = this

    data =
      code: code
      amount: @currentTotal

    $.ajax
      url: "/discount"
      data: data
      type: "POST"
      success: (result) ->
        result = $.parseJSON(result)
        console.log result
        if result.status

          that.saveDiscount($button, $input, code, result)
        else
          that.errorState($button, $input)

  saveDiscount: ($button, $input, code, data) ->
    @successState($button, $input)
    @currentTotal = data.sum
    @currentPercentage = @currentPercentage + parseInt(data.discount)
    @savedCodes.push(code)
    @updatePriceCalculator(data)

    eventData =
      amount: @currentTotal
      percentage: @currentPercentage
      codes: @savedCodes

    app.eventListener.fire "discount", "added", eventData

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

  updatePriceCalculator: (data) ->
    @el.find(".js-priceCal").addClass("is-reduced")
    @el.find(".js-priceResult").text(data.sum)
    @el.find(".js-discount").text(@defaultTotal - @currentTotal)
    @el.find(".js-discountPercentage").text(@currentPercentage)


