$(document).on('ready page:load', function () {
  $('.input-append.date.datepicker_future').datepicker({
    format: 'dd-mm-yyyy',
    startDate: '-100y',
    todayBtn: 'linked',
    autoclose: true,
    todayHighlight: true,
    language: "es"
  });
});