#= require lib/jquery.js
#= require lib/jquery.tablesorter.js
#= require lib/bootstrap.js

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
      $form = $input.closest("form")
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
        that.updateDatabase(id, checked, $form)

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

  updateDatabase: (id, state, form) ->
    $.ajax
      url: form.attr("action")
      data: form.serialize()
      type: "PUT"
      success: (result) ->
        console.log result


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
