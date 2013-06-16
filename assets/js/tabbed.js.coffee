app.tabbed =
  init: ($element) ->
    @el = $element
    @navItems = @el.find('.js-tabbedNavItem')
    @sections = @el.find('.js-tabbedSection')
    @eventListeners()

  eventListeners: ->
    that = this

    @el.find('.js-tabbedNavItem').click (e) ->
      e.preventDefault();
      index = $('.js-tabbedNavItem').index($(this))
      that.setNavItemActive(index)
      that.showSection(index)


  setNavItemActive: (index) ->
    @navItems.removeClass('is-active')
    $(@navItems.get(index)).addClass('is-active')


  showSection: (index) ->
    @sections.addClass('u-isHidden')
    $(@sections.get(index)).removeClass('u-isHidden')
