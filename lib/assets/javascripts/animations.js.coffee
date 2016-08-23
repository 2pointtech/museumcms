(($)->
  $.fn.staggerin = (sel, options = {})->
    $(this).find(sel).css
      translate: "-#{$(this).outerWidth() + $(this).position().left}px"
    delay = options.startDelay || 0
    async.each $(this).find(sel),
      (item, callback) =>
        $(item).transition
          x: '0px'
          delay: delay
          easing: 'snap'
          complete: callback
        delay += options.delay
      =>
        if options.complete
          options.complete()

  $.fn.staggerout = (sel, options = {})->
    delay = 0
    x = $(this).outerWidth() + $(this).position().left
    async.each $(this).find(sel),
      (item, callback) =>
        $(item).transition
          x: "-#{x}px"
          delay: delay
          easing: 'snap'
          complete: callback
        delay += 50
      =>
        if options.complete
          options.complete()

)(jQuery)
