#= require setup.js
#= require shop.js

$("#payment-form").submit (event) ->
  event.preventDefault()
  #$(".submit-button").attr "disabled", "disabled"

  unless paymill.validateCardNumber($(".card-number").val())
    console.log "VALIDATE CARD NUMBER"
    $(".payment-errors").text "Invalid card number"
    $(".submit-button").removeAttr "disabled"
    return false
  unless paymill.validateExpiry($(".card-expiry-month").val(), $(".card-expiry-year").val())
    console.log "VALIDATE EXPIRY"
    $(".payment-errors").text "Invalid expiration date"
    $(".submit-button").removeAttr "disabled"
    return false

  console.log "CREATE TOKEN"
  paymill.createToken
    number: $(".card-number").val()
    exp_month: $(".card-expiry-month").val()
    exp_year: $(".card-expiry-year").val()
    cvc: $(".card-cvc").val()
    cardholder: $(".card-holdername").val()
    amount_int: $(".card-amount-int").val() # Integer z.B. "4900" für 49,00 EUR
    currency: $(".card-currency").val() # ISO 4217 z.B. "EUR"
  , PaymillResponseHandler
  false

PaymillResponseHandler = (error, result) ->
  console.log "RESPONSE HANDLER"
  console.log "error", error
  console.log "result", result

  if error
    # Displays the error above the form
    $(".payment-errors").text error.apierror
  else
    $(".payment-errors").text ""
    form = $("#payment-form")
    
    # Token
    token = result.token
    
    # Insert token into form in order to submit to server
    form.append "<input type='hidden' name='paymillToken' value='" + token + "'/>"
    #form.get(0).submit()
  #$(".submit-button").removeAttr "disabled"
