(($)->
  $.fn.scrollbar = (options = {})->
    bar = $(this).find('.scrollbar')
    scrubber = $(this).find('.scrubber')
    body = $(this).find('.body')

    contentHeight = body.find('> div').height()
    containerHeight = body.height()

    ratio = containerHeight / contentHeight

    if body.outerHeight() < 250
      $(this).find('.scroll').hide()
      return

    scrubber.css
      height: (bar.height() * ratio) - 20

    updateBar = ->
      offset = body.scrollTop()
      scrubber.css
        top: offset * ratio

    timer = null
    $(this).find('.arrowdown').on 'touchstart', ->
      console.log 'arrow down start '
      timer = setInterval ->
        offset = body.scrollTop()
        if offset < contentHeight - containerHeight
          console.log offset
          body.scrollTop(offset + 20)
          updateBar()
      , 100

    $(this).find('.arrowdown').on 'touchend', ->
      console.log 'arrow down end '
      clearInterval timer

    $(this).find('.arrowup').on 'touchstart', ->
      timer = setInterval ->
        offset = body.scrollTop()
        if (offset > 0)
          body.scrollTop(offset - 20)
          updateBar()
      , 100

    $(this).find('.arrowup').on 'touchend', ->
      clearInterval timer

    scroll = new Hammer.Manager bar[0]
    scroll.add( new Hammer.Pan({ direction: Hammer.DIRECTION_VERTICAL }))
    #options.parentHammer.get('pan').requireFailure(scroll.get('pan'))
    #options.parentHammer.get('rotate').requireFailure(scroll.get('pan'))
    #options.parentHammer.get('pinch').requireFailure(scroll.get('pan'))

    scroll.on 'panmove', (ev)=>
      ev.srcEvent.stopPropagation()
      offset = (ev.deltaY * ratio * 0.5)
      offset *= -1 if $(this).closest('.upsidedown').length > 0
      scrollTop = body.scrollTop() + offset
      console.log scrollTop
      if scrollTop > 0 and scrollTop < contentHeight - containerHeight
        body.scrollTop scrollTop
        updateBar()

)(jQuery)
