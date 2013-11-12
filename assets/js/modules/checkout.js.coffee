app.checkout =
  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @readyToBuy = false
    @binds()

  binds: ->
    that = this

    #@el.find('.js-next').click (e) ->
    #  e.preventDefault()
    #  if that.el.valid()
    #    that.showConfirm()

    #@el.find('.js-prev').click (e) ->
    #  e.preventDefault()
    #  that.showForm()

    @el.submit (e) ->
      e.preventDefault()
      $('.js-buy').attr('disabled', 'disabled').find('span').text('Loading…')
      $('.js-buy').siblings('a').addClass('is-disabled')
      that.createToken()

    # Support for pressing enter key
    $(document).keypress (e) ->
      if e.which is 13
        e.preventDefault()
        that.nextAction()

    # Prefill card name from shipping name
    @el.find('#card-holdername').one 'focus', (e) ->
      $this = $(this)
      if $this.val().length == 0
        validShippingName = that.el.find('#order-name.is-valid').val()
        $this.val(validShippingName)

  showConfirm: (e) ->
    @enterConfirmData()
    @el.find('.js-checkoutForm').addClass('u-isHidden')
    @el.find('.js-checkoutConfirm').removeClass('u-isHidden')
    @readyToBuy = true

  showForm: (e) ->
    @el.find('.js-checkoutForm').removeClass('u-isHidden')
    @el.find('.js-checkoutConfirm').addClass('u-isHidden')
    @readyToBuy = false

  nextAction: (e) ->
    if @readyToBuy
      @el.find('.js-buy').click()
    else
      @el.find('.js-next').click()

  enterConfirmData: (e) ->
    fields = ["name", "email", "phone", "country", "street", "city", "postalCode"]
    for field in fields
      $("#confirm-#{field}").text(@el.find("#order-#{field}").val())

    cardNumber = @el.find("#card-number").val()
    firstDigets = cardNumber.substr(0, 5)
    cardType = $.payment.cardType(cardNumber)
    cardType = cardType.charAt(0).toUpperCase() + cardType.slice(1)
    $('#confirm-cardNumber').text(firstDigets)
    $('#confirm-cardType').text(cardType)

  createToken: (e) ->
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
