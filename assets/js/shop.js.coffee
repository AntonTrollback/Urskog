app.shop =
  init: ($element) ->
    @el = $element
    @eventListeners()

  eventListeners: ->
    that = this

    # Radio buttons are used to determine shop content
    @el.on 'change', '.js-shopControl', (e) ->
      that.changeShopContent($(this).attr('id'))

    # Change shop content now, onload, because radio button state can be
    # preserved when moving in browser history
    @changeShopContent(@el.find('.js-shopControl:checked').attr('id'))


  changeShopContent: (optionName) ->
    @el.find('.js-shopOption').addClass('u-isHidden')
    @el.find("##{optionName}Content").removeClass('u-isHidden')


