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

    # Custom minimum length test for names because other one did not work
    $.validator.addMethod "v-name", ((value, element) ->
      @optional(element) or value.length >= 4 # Paymill set this limit
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