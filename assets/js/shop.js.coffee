app.shop =
  init: ($element) ->
    @el = $element
    @eventListeners()

  eventListeners: ->
    that = this

    # Radio buttons are used to determine shop content
    @el.on 'change', '.js-shopControl', (e) ->
      that.changeShopContent($(this).attr('id'))

    # Let's update shop content now, onload, because checked state's can be
    # preserved if moving in browser history
    @changeShopContent(@el.find('.js-shopControl:checked').attr('id'))


  changeShopContent: (optionName) ->
    @el.find('.js-shopOption').addClass('u-isHidden')
    @el.find("##{optionName}Content").removeClass('u-isHidden')