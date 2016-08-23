(($)->

  getRandomInt = (min, max)->
    return Math.floor(Math.random() * (max - min + 1)) + min

  $.fn.pulsate = (options = {})->
    delay = 5000
    interval = $(this).length * delay
    for el in $(this)
      do (el)->
        $el = $(el)
        if options == 'detach'
          timer =  $el.data('timer')
          clearInterval timer
          return


        pulse = ->
          ring1 = $('<div>')
          ring2 = $('<div>')
          $el.append ring1
          $el.append ring2

          ring1.css
            position: 'absolute'
            pointerEvents: 'none'
            top: 0
            width: $el.width()
            height: $el.height()
            backgroundColor: 'white'
            borderRadius: $el.css('border-radius')
            overflow: 'hidden'
            scale: 0.1
          ring2.css
            position: 'absolute'
            pointerEvents: 'none'
            top: 0
            width: $el.width()
            height: $el.height()
            backgroundColor: 'white'
            borderRadius: $el.css('border-radius')
            overflow: 'hidden'
            console.log 'pulsing'
            scale: 0.1
          ring2.transition
            scale: 1
            opacity: 0
            duration: 800
            complete: ->
              ring2.remove()

          setTimeout ->
            ring1.transition
              scale: 1
              opacity: 0
              duration: 900
              complete: ->
                ring1.remove()
          , 100

        timeout = getRandomInt(0, interval)
        setTimeout ->
          pulse()
          timer = setInterval pulse, interval
          $el.data('timer', timer)
        , timeout
)(jQuery)
