# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require bootstrap-datepicker
$ ->
  $('#save-btn').click ->
    selectedDatas = []
    $('.ig_post.selected').each (index) ->
      data = $(this).data()
      selectedDatas[index] = data.param
      return
    if selectedDatas.length == 0
      return false
    else
        $('#data_str').val('[' + selectedDatas + ']')
    return