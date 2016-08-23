$ ->
  $('.collapse').click ->
    if $(this).closest('div').find('.collapseable').is(':hidden')
      $(this).html '-'
    else
      $(this).html '+'
    $(this).closest('div').find('.collapseable').slideToggle()
