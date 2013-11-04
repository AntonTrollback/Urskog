app.validator =
  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @customTests()
    @initPlugin()
    @binds()

  binds: ->
    that = this

    @el.on 'click', '.v-submit', (e) ->
      e.preventDefault()
      if that.el.valid()
        that.el.submit()

  initPlugin: ->
    @el.validate(
      errorClass: "is-invalid"
      validClass: "is-valid"
      ignore: ":hidden"
      focusInvalid: true
      errorPlacement: (error, field) ->
      success: (label, field) ->
    )

  customTests: ->

    # Extend validation with jquery.payment plugin
    $('.v-cardNumber').payment('formatCardNumber');
    $('.v-expiry').payment('formatCardExpiry');
    $('.v-cvc').payment('formatCardCVC');

    # Namespace email test
    $.validator.addClassRules "v-email", ->
      email: true

    # Valid giftcard
    $.validator.addMethod "v-giftcard", ((value, element) ->
      @optional(element) or (value.length == 10 and /^[A-Za-z0-9]+$/.test(value))
    ), "msg"

    # Has 4 or more characters
    $.validator.addMethod "v-length", ((value, element) ->
      @optional(element) or value.length >= 4 # Also a Paymill limit
    ), "msg"

    # Card number
    $.validator.addMethod "v-cardNumber", ((value, element) ->
      @optional(element) or $.payment.validateCardNumber(value)
    ), "msg"

    # Card expiry
    $.validator.addMethod "v-expiry", ((value, element) ->
      @optional(element) or $.payment.validateCardExpiry($(element).payment('cardExpiryVal'))
    ), "msg"

    # CVC
    $.validator.addMethod "v-cvc", ((value, element) ->
      @optional(element) or $.payment.validateCardCVC(value)
    ), "msg"