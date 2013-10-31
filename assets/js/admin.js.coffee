#= require jquery.js
#= require bootstrap.js
#= require jquery.tablesorter.js

console.log("Disabling Autopilot... You're in charge now")

app = {}

$ ->
  app.giftcardList.init($('.giftcard-list'))



app.giftcardList =
  init: ($element) ->
    @el = $element
    @table = @el.find(".table-sort")
    @events()
    @initSorter()

  events: ->
    that = this

    $(".table-checkbox").on "change", "input", ->
      $input = $(this)
      $form = $input.closest('form')
      $label = $input.parent()
      checked = $input.is(":checked")

      if checked
        $label.addClass("active").find("span").text("1")
      else
        $label.removeClass("active").find("span").text("0")

      that.updateSorter()
      that.updateDatabase($form, checked)

  initSorter: ->
    @table.tablesorter({
      cssHeader: "table-head"
      cssDesc: "table-desc"
      cssAsc: "table-asc"
      sortList: [[1, 0]]
      headers: { 0: { sorter: false}}
    })

  updateSorter: ->
    @table.trigger("update")

  updateDatabase: (form, state) ->
    console.log("AJAX:", form, state)



