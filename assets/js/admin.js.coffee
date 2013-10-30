#= require jquery.js
#= require bootstrap.js
#= require jquery.tablesorter.js

console.log("Disabling Autopilot... You're in charge now")

$ ->

  $(".table-sort").tablesorter({
    sortList: [[1, 0]]
    cssHeader: "table-head"
    cssDesc: "table-desc"
    cssAsc: "table-asc"
  })
