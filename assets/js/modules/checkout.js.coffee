app.checkout =

  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @binds()

  binds: ->
    that = this

    app.eventListener.add "walker", "walked", (data) ->
      if data.direction = "forward"
        if data.id == "card-details"
          that.prefillCardName()
        else if data.id == "confirm"
          that.printConfirmData()

    app.eventListener.add "discount", "added", (data) ->
      # Update DOM

    @el.on "click", ".js-buy", (e) ->
      e.preventDefault()
      that.createToken()
      $(this).attr("disabled", "disabled")
        .find("span").text("Loading…").end()
        .siblings("a").addClass("is-disabled")

  prefillCardName: ->
    $cardName = @el.find("#card-holdername")
    if $cardName.val().length == 0
      $cardName.val(@el.find("#order-name.is-valid").val())

  printConfirmData: ->
    fields = ["name", "email", "phone", "country", "street", "city", "postalCode"]
    for field in fields
      $("#confirm-#{field}").text(@el.find("#order-#{field}").val())

    number = @el.find("#card-number").val()
    firstFour = number.substr(0, 5)
    cardNumber = $.payment.cardType(number)
    cardNumber = cardNumber.charAt(0).toUpperCase() + cardNumber.slice(1)
    $("#confirm-cardNumber").text(firstFour)
    $("#confirm-cardType").text(cardNumber)

  createToken: ->
    # Paymill do not like name attribute
    @el.find("[name*=card]").removeAttr("name")

    paymill.createToken
      number:     @el.find("#card-number").val()
      exp_month:  @el.find("#card-expiry").payment("cardExpiryVal").month
      exp_year:   @el.find("#card-expiry").payment("cardExpiryVal").year
      cvc:        @el.find("#card-cvc").val()
      cardholder: @el.find("#card-holdername").val()
      amount_int: @el.find("#card-amountInt").val() # Integer z.B. "4900" für 49,00 EUR
      currency:   @el.find("#card-currency").val() # ISO 4217 z.B. "EUR"
    , @paymillResponseHandler

  paymillResponseHandler: (error, result) =>
    that = window.app.checkout

    if error
      console.log "Error: ", error
      alert "Something went wrong :("
    else
      # Insert fresh token in order to submit to server
      that.el.find(".token").remove()
      that.el.append "<input type='hidden' name='order[token]' class='token' value='" + result.token + "'/>"
      that.el.get(0).submit()
