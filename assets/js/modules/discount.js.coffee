app.discount =

  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @controls = @el.find(".js-discountControl")
    @data =
      initPrice: parseInt(@el.find(".js-priceResult").text())
      price: parseInt(@el.find(".js-priceResult").text())
      discount: 0
      codes: []
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
      that.enterDiscount($this, $input)

    # Clear states on input focus
    @controls.on "focus", "input", (e) ->
      e.preventDefault()
      $button = $(this).siblings("button")
      that.clearState($button, $(this))

    # Disable enter key
    @controls.on "keypress", "input", (e) ->
      if e.which == 13
        false

    # Alert if discount field is filled but not saved
    app.eventListener.add "walker", "walked", (data) ->
      if data.id == "shipping-information"
        unsaved = that.controls.not(".u-isHidden").find("input:not(.is-correct)").filter ->
          $(this).val() isnt ""
        if unsaved.length isnt 0
          alert("You have an unsaved discount. Go back and press the save button if you wish to use it for this purchase")

  showControl: ($button) ->
    @controls
      .not(":not(.u-isHidden)")
        .first()
          .removeClass("u-isHidden")
          .find("input")
            .focus()
    unless @controls.is(".u-isHidden")
      $button.hide()

  enterDiscount: ($button, $input) ->
    value = $input.val()

    if @validateDiscount(value)
      @loadingState($button, $input)
      @getStatus($button, $input, value)
    else
      @errorState($button, $input, "Invalid")

  validateDiscount: (value) ->
    that = this
    $.inArray(value, @data.codes) == -1 and (value.length == 10 and /^[A-Za-z0-9]+$/.test(value))

  getStatus: ($button, $input, code) ->
    that = this

    data =
      code: code
      amount: @data.price
      default: @data.initPrice

    $.ajax
      url: "/discount"
      data: data
      type: "POST"
      success: (result) ->
        result = $.parseJSON(result)
        console.log(result)
        if result.status
          that.saveDiscount($button, $input, code, result)
        else
          that.errorState($button, $input)

  saveDiscount: ($button, $input, code, data) ->
    @successState($button, $input)
    @data.price = data.sum
    @data.discount = @data.discount + parseInt(data.discount)
    @data.codes.push(code)
    @displayPrice(data)

    data =
      price: @data.price
      discount: @data.discount
      codes: @data.codes

    app.eventListener.fire "discount", "added", data

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

  displayPrice: (data) ->
    @el.find(".js-priceCal").addClass("is-reduced")
    @el.find(".js-priceResult").text(data.sum)
    @el.find(".js-discount").text(@data.initPrice - @data.price)
    @el.find(".js-discountPercentage").text(@data.discount)


