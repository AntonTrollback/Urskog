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
    console.log "CREATE TOKEN"
    paymill.createToken
      number:     $(".card-number").val()
      exp_month:  $(".card-expiry-month").val()
      exp_year:   $(".card-expiry-year").val()
      cvc:        $(".card-cvc").val()
      cardholder: $(".card-holdername").val()
      amount_int: $(".card-amount-int").val() # Integer z.B. "4900" für 49,00 EUR
      currency:   $(".card-currency").val() # ISO 4217 z.B. "EUR"
    , @PaymillResponseHandler


  PaymillResponseHandler: (error, result) ->
    console.log "error", error
    console.log "result", result

    unless error
      # Insert token into form in order to submit to server
      @el.append "<input type='hidden' name='order[token]' value='" + result.token + "'/>"
      @el.get(0).submit()