// Generated by CoffeeScript 1.4.0
(function() {

  window.app = {};

  MBP.hideUrlBarOnLoad();

  MBP.scaleFix();

  $(function() {
    return $('.shop').on('change', 'input', function(e) {
      var $parent;
      console.log($(this));
      $parent = $(this).closest('.shop');
      $parent.find('.shop__option').removeClass('is-active');
      return $parent.find(".js-" + ($(this).attr('id'))).addClass('is-active');
    });
  });

  (function($) {
    return $.fn.alterClass = function(removals, additions) {
      var patt, self;
      self = this;
      if (removals.indexOf("*") === -1) {
        self.removeClass(removals);
        return (!additions ? self : self.addClass(additions));
      }
      patt = new RegExp("\\s" + removals.replace(/\*/g, "[A-Za-z0-9-_]+").split(" ").join("\\s|\\s") + "\\s", "g");
      self.each(function(i, it) {
        var cn;
        cn = " " + it.className + " ";
        while (patt.test(cn)) {
          cn = cn.replace(patt, " ");
        }
        return it.className = $.trim(cn);
      });
      if (!additions) {
        return self;
      } else {
        return self.addClass(additions);
      }
    };
  })(jQuery);

}).call(this);
