app.checkout =
  init: ($element) ->
    @el = $element
    @readyToBuy = false
    @eventListeners()


  eventListeners: ->
    that = this

    # Init validation
    app.validator.init(@el)

    @el.find('.js-next').click (e) ->
      e.preventDefault()
      if that.el.valid()
        that.showConfirm()

    @el.find('.js-prev').click (e) ->
      e.preventDefault()
      that.showForm()

    @el.submit (e) ->
      e.preventDefault()
      # Validate again just to be sure
      if that.el.valid()
        that.createToken()
      else
        that.showForm()

    # Support for pressing enter key
    $(document).keypress (e) ->
      if e.which is 13
        e.preventDefault()
        that.nextAction()



  showConfirm: (e) ->
    @el.find('.js-checkoutForm').addClass('u-isHidden')
    @el.find('.js-checkoutConfirm').removeClass('u-isHidden')
    @readyToBuy = true


  showForm: (e) ->
    @el.find('.js-checkoutForm').removeClass('u-isHidden')
    @el.find('.js-checkoutConfirm').addClass('u-isHidden')
    @readyToBuy = false


  nextAction: (e) ->
    if @readyToBuy
      $('.js-buy').click()
    else
      $('.js-next').click()


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
      console.log "Error: ", error
      alert "Something went wrong :("
      that.showForm()
    else
      console.log "Result: ", result
      # Insert fresh token in order to submit to server
      that.el.find("[name=order[token]").remove()
      that.el.append "<input type='hidden' name='order[token]' value='" + result.token + "'/>"
      #that.el.get(0).submit()