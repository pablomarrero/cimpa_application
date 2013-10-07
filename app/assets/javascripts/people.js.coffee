# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
init = ->
  $('#person_birth_date').datepicker({
    format: 'yyyy-mm-dd',
    startDate: '-100y',
    endDate: '+0d',
    todayBtn: 'linked',
    autoclose: true,
    todayHighlight: true
  })
  $('.combobox').combobox()
  $(".friends").on "cocoon:after-insert", (e, insertedItem) -> insertedItem.find('.combobox').combobox()


$(document).ready init
$(document).on "page:load", init

