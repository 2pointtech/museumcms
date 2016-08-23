(($)->
  $.fn.pangimate = (prefix, n, ext)->
    for i in [1..n]
      $(this).append($('<img>').attr(src: "#{prefix}#{i}.#{ext}").hide())

    $($(this).find('img')[1]).show()
    index = 1
    animating = true
    animate = =>
      visible = this.find('img:visible')
      $($(this).find('img')[index-1]).show()
      visible.hide()

      index++
      timeout = 90
      if index > n
        index = 1
        timeout = 3000
      timer = setTimeout ->
        if animating
          req = requestAnimationFrame animate
      , timeout
    timer = setTimeout ->
      requestAnimationFrame animate
    , 1000

    $(this).on 'remove', ->
      animating = false
      clearTimeout timer

)(jQuery)
