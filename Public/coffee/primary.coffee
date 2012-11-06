
window.app = {}

# init H5BP mobile plugins
MBP.hideUrlBarOnLoad()
MBP.scaleFix()



$ ->

  $('.shop').on 'change', 'input', (e) ->
    $('.shop').alterClass("is-*", "is-" + $(this).attr('id'))



(($) ->
  $.fn.alterClass = (removals, additions) ->
    self = this
    if removals.indexOf("*") is -1
      
      # Use native jQuery methods if there is no wildcard matching
      self.removeClass removals
      return (if not additions then self else self.addClass(additions))
    patt = new RegExp("\\s" + removals.replace(/\*/g, "[A-Za-z0-9-_]+").split(" ").join("\\s|\\s") + "\\s", "g")
    self.each (i, it) ->
      cn = " " + it.className + " "
      cn = cn.replace(patt, " ")  while patt.test(cn)
      it.className = $.trim(cn)

    (if not additions then self else self.addClass(additions))
) jQuery