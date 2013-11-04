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
    return false  unless @el.length
    @table = @el.find(".table-sort")
    @retainerMover = @el.find(".retailer-mover")
    @markedForMoving = []
    @binds()
    @initSorter()
    @highlightLinkedItem()

  binds: ->
    that = this

    $(".table-checkbox").on "change", "input", ->
      $input = $(this)
      $label = $input.closest("label")
      id = $input.closest("tr").attr("id")
      checked = $input.is(":checked")
      typeStatus = $label.is(".table-status")
      typeMark = $label.is(".table-mark")

      if checked
        $label.addClass("active").find("span").text("1")
      else
        $label.removeClass("active").find("span").text("0")

      if typeMark
        that.updateRetailerMover(id)
      else if typeStatus
        that.updateDatabase(id, checked)

      that.updateSorter()

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

  updateDatabase: (id, state) ->
    console.log("AJAX:", id, state)

  updateRetailerMover: (id) ->
    found = $.inArray(id, @markedForMoving)
    if found >= 0
      @markedForMoving.splice found, 1
    else
      @markedForMoving.push(id)
    @updateRetailerForm()

  updateRetailerForm: ->
    @retainerMover.find("[type='hidden']").val(@markedForMoving)

    if @markedForMoving.length
      @retainerMover
        .find("button").attr("disabled", false)
        .find("span").text("(#{@markedForMoving.length})")
    else
      @retainerMover
        .find("button").attr("disabled", true)
        .find("span").text("(0)")

  highlightLinkedItem: ->
    id = location.hash.substring(1)
    $("##{id}").addClass('highlighted-row')