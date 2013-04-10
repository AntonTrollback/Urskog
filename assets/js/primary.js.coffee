
window.app = {}

# init H5BP mobile plugins
MBP.hideUrlBarOnLoad()
MBP.scaleFix()



$ ->

  $('.js-displayOption').on 'change', 'input', (e) ->
    $parent = $(this).closest('.js-displayOption')
    $parent.find('.js-option').addClass('u-isHidden')
    $parent.find(".js-#{$(this).attr('id')}").removeClass('u-isHidden')