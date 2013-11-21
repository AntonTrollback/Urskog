app.shop =
  init: ($element) ->
    @el = $element
    return false  unless @el.length
    @binds()

  binds: ->
    that = this

    # Radio buttons are used to determine shop content
    @el.on 'change', '.js-updateAction', (e) ->
      that.setAction($(this).find('option:selected').val())

    # Radio buttons are used to determine shop content
    @el.on 'change', '.js-shopControl', (e) ->
      that.setShopContent()

    # Run onload because radio button states might
    # be preserved when moving in browser history
    @setShopContent()

  setAction: (action) ->
    @el.attr('action', action)

  setShopContent: ->
    $input = @el.find('.js-shopControl:checked')
    $select = @el.find('.js-shopControl option:selected')

    if $input.length
      id = $input.attr('id')
    else
      id = $select.attr('id')

    @el.find(".js-shopOption:not(##{id}Content)").addClass('u-isHidden')
    @el.find("##{id}Content").removeClass('u-isHidden')
