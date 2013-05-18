app.checkout =
  init: ($element) ->
    @el = $element
    @eventListeners()


  eventListeners: ->
    that = this

    # Init validation
    app.validator.init(@el)

    @el.submit (e) ->
      e.preventDefault()
      if that.el.valid()
        that.createToken()


  createToken: (e) ->
    paymill.createToken
      number:     $("[name=card-number]").val()
      exp_month:  $("[name=card-expiry]").payment('cardExpiryVal').month
      exp_year:   $("[name=card-expiry]").payment('cardExpiryVal').year
      cvc:        $("[name=card-cvc]").val()
      cardholder: $("[name=card-holdername]").val()
      amount_int: $("[name=card-amount-int]").val() # Integer z.B. "4900" für 49,00 EUR
      currency:   $("[name=card-currency]").val() # ISO 4217 z.B. "EUR"
    , @PaymillResponseHandler


  PaymillResponseHandler: (error, result) =>
    that = window.app.checkout

    if error
      alert "Something went wrong :("
      console.log "Error: ", error
    else
      console.log "Result: ", result
      # Insert token in order to submit to server
      that.el.append "<input type='hidden' name='order[token]' value='" + result.token + "'/>"
      #that.el.get(0).submit()