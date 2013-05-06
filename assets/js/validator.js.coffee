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
        $(field).closest('.Control').addClass('is-invalid').removeClass('is-valid')
      success: (label, field) ->
        $(field).closest('.Control').addClass('is-valid').removeClass('is-invalid')
    )


  customTests: ->
    # Namespace email test
    $.validator.addClassRules "v-email", ->
      email: true

    # Card number
    $.validator.addMethod "v-cardNumber", ((value, element) ->
      @optional(element) or paymill.validateCardNumber(value)
    ), "msg"

    # Card year
    $.validator.addMethod "v-expiryYear", ((value, element) ->
      # Paymill's validation ask for both year and month so let's
      # fake one or the other to get single field validation
      @optional(element) or paymill.validateExpiry('12', value)
    ), "msg"

    # Card month
    $.validator.addMethod "v-expiryMonth", ((value, element) ->
      @optional(element) or paymill.validateExpiry(value, '2050')
    ), "msg"

    # CVC
    $.validator.addMethod "v-cvc", ((value, element) ->
      @optional(element) or paymill.validateCvc(value)
    ), "msg"