app.validator =
  init: ($element) ->
    @el = $element

    # Extend jQuery Validation Plugin
    @customTests()

    # Init jQuery Validation Plugin
    @el.validate(
      errorClass: "is-invalid"
      validClass: "is-valid"
      ignore: ":hidden"
      focusInvalid: true
      errorPlacement: (error, field) ->
      success: (label, field) ->
    )

    # Init jquery.payment from Stipe
    $('.v-cardNumber').payment('formatCardNumber');
    $('.v-expiry').payment('formatCardExpiry');
    $('.v-cvc').payment('formatCardCVC');


  customTests: ->

    # Namespace email test
    $.validator.addClassRules "v-email", ->
      email: true

    # Has 4 or more characters
    $.validator.addMethod "v-length", ((value, element) ->
      @optional(element) or value.length >= 4 # Also a Paymill limit
    ), "msg"

    # Card number
    $.validator.addMethod "v-cardNumber", ((value, element) ->
      $.payment.validateCardNumber(value)
    ), "msg"

    # Card expiry
    $.validator.addMethod "v-expiry", ((value, element) ->
      $.payment.validateCardExpiry($(element).payment('cardExpiryVal'))
    ), "msg"

    # CVC
    $.validator.addMethod "v-cvc", ((value, element) ->
      $.payment.validateCardCVC(value)
    ), "msg"