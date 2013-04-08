
window.app = {}

# init H5BP mobile plugins
MBP.hideUrlBarOnLoad()
MBP.scaleFix()



$ ->

  $('.shop').on 'change', 'input', (e) ->
    $parent = $(this).closest('.shop')
    $parent.find('.shop__option').removeClass('is-active')
    $parent.find(".js-#{$(this).attr('id')}").addClass('is-active')


