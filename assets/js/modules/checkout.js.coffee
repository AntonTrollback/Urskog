app.checkout =

  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @readyToBuy = false
    @buyButton = @el.find(".js-buy")
    @binds()

  binds: ->
    that = this

    app.eventListener.add "walker", "walked", (data) ->
      if data.direction = "forward"
        if data.id == "card-details"
          that.prefillCardName()
        else if data.id == "confirm"
          that.printConfirmData()

    @el.submit (e) ->
      e.preventDefault()
      that.buyButton.attr('disabled', 'disabled').find('span').text('Loading…')
      that.buyButton.siblings('a').addClass('is-disabled')
      that.createToken()

  prefillCardName: ->
    # Prefill from valid shipping name
    $cardName = @el.find('#card-holdername')
    if $cardName.val().length == 0
      $cardName.val(@el.find('#order-name.is-valid').val())

  printConfirmData: ->
    fields = ["name", "email", "phone", "country", "street", "city", "postalCode"]
    for field in fields
      $("#confirm-#{field}").text(@el.find("#order-#{field}").val())

    cardNumber = @el.find("#card-number").val()
    firstDigets = cardNumber.substr(0, 5)
    cardType = $.payment.cardType(cardNumber)
    cardType = cardType.charAt(0).toUpperCase() + cardType.slice(1)
    $('#confirm-cardNumber').text(firstDigets)
    $('#confirm-cardType').text(cardType)

  createToken: ->
    # Paymill do not like name attribute
    @el.find('[name*=card]').removeAttr('name')

    paymill.createToken
      number:     @el.find("#card-number").val()
      exp_month:  @el.find("#card-expiry").payment('cardExpiryVal').month
      exp_year:   @el.find("#card-expiry").payment('cardExpiryVal').year
      cvc:        @el.find("#card-cvc").val()
      cardholder: @el.find("#card-holdername").val()
      amount_int: @el.find("#card-amountInt").val() # Integer z.B. "4900" für 49,00 EUR
      currency:   @el.find("#card-currency").val() # ISO 4217 z.B. "EUR"
    , @PaymillResponseHandler

  PaymillResponseHandler: (error, result) =>
    that = window.app.checkout

    if error
      console.log "Error: ", error
      alert "Something went wrong :("
      that.showForm()
    else
      # Insert fresh token in order to submit to server
      that.el.find(".token").remove()
      that.el.append "<input type='hidden' name='order[token]' class='token' value='" + result.token + "'/>"
      that.el.get(0).submit()
