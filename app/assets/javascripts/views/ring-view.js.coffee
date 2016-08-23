class di.views.RingView extends Backbone.View
  initialize: (@options)->
    @moving = false
    @leftOffset = 0
    @popups = []
  className: 'ring cn-wrapper'
  events:
    'click .rotate-handle': 'rotate'
    'touchstart': 'bringToTop'
  render: ->
    @$el.html JST['ring']
    @$el.attr id: "ring#{@options.sessionId}"
    @lastLeft = 0
    @lastTop = 0
    @lastAngle = @options.a || 0
    @update @options.x, @options.y, @options.a
    @moving = false
    @updsideDown = false
    @animals = []
    @$el
  update: (x, y, a) ->
    glassWidth = @$('.window-glass').width()
    glassHeight = @$('.window-glass').height()
    x = -glassWidth / 2 if x < -glassWidth / 2
    y = -glassHeight / 2 if y < -glassHeight / 2
    x = $(window).width() - (glassWidth * 1.5)  if x > $(window).width() - (glassWidth * 1.5)
    y = $(window).height() - (glassHeight * 1.5) if y > $(window).height() - (glassHeight * 1.5)

    requestAnimationFrame =>
      @$el.css
        left: x
        top: y
      if a
        degrees = a
        @$('.offset').css
          transform: "rotate(#{degrees}deg)"
        @lastAngle = a
      @lastLeft = x
      @lastTop = y
      @over()
      @moving = true
      if a
        @flip(a)
      clearTimeout @movingTimer
      @movingTimer = setTimeout =>
        @moving = false
      , 200
  dispose: ->
    @remove()
    @closePopups()
  over: ()->
    position = @$('.window-glass').offset()
    top = position.top
    left = position.left
    bottom = top + @$('.window-glass').outerHeight()
    right = left + @$('.window-glass').outerWidth()
    approaching = false
    for site in di.sites
      x = site.x
      y = site.y
      w = 100
      h = 50
      if top < y + h and bottom > y and left < x + w and right > x
        approaching = true
        degrees = @lastAngle
        unless _.contains @animals, site.id
          animal = $('<div>').addClass("animal site#{site.id}")
          animal  .css
            backgroundImage: "url(#{site.image.url})"
          @$('.window-glass').after animal
          @animals.push site.id

        animalX = -(left - x)
        animalY = -(top - y)

        if degrees == 180 
          animalX = (animalX * -1) + 50
          animalY = (animalY * -1) + 70

        @$(".animal.site#{site.id}").css
          backgroundPositionX: animalX
          backgroundPositionY: animalY
      else
        if _.contains @animals, site.id
          @$(".animal.site#{site.id}").remove()
          @animals = _.without(@animals, site.id)

    for site in di.sites
      x = site.x
      y = site.y
      w = 100
      h = 50
      if (top + 40) < y + h and (bottom - 40) > y and (left + 40) < x + w and (right - 40) > x
        found = site
        break
      else
        found = null

    # There's an active ring but a new one was not found, or a different one was found
    if @current and (!found or found.id != @current.id)
      clearTimeout @openTimeout
      @$el.removeClass('opened-nav')
      @closePopups()
      @current = null
      @off 'popup:change'

    # There's no active ring, and a new one was found
    if found and !@current
      @current = found
      @$('ul').html ''
      for menu in @current.menus
        do (menu, x, y)=>
          wedge = $('<li>').html($('<a>').html($('<span>').html(menu.label)))
          wedge.find('a').css
            background: "-webkit-radial-gradient(transparent 48%, #{site.color} 35%)"
          @$('.wedges').append wedge
          wedge.on 'touchstart', 'span', (e)=>
            unless @moving
              @popup menu, wedge.index()
            else
              console.log "Ignoring click because we're moving"
      wedge = $('<li>').html($('<a>').html($('<span>').html('Gather')))
      wedge.find('a').css
        background: "-webkit-radial-gradient(transparent 48%, #{site.color} 35%)"
      @$('.wedges').append wedge
      wedge.on 'touchstart', 'span', (e)=>
        unless @moving
          @gatherPopups()

      wedge.hide()
      @on 'popup:change', =>
        if @popups.length > 1
          wedge.fadeIn()
        else
          wedge.fadeOut()
  
      clearTimeout @openTimeout
      @openTimeout = setTimeout =>
        @$el.addClass('opened-nav')
        $(".popups .site#{@current.id}").remove()
        $(".popups").append $('<div>').addClass("site#{@current.id}")
      , 500

    # No active right and no found ring
    if !@current and !found and !approaching
      @animals = []
      @$(".animal").remove()

    return false
  popup: (menu, index)->
    if $("#popup#{menu.id}").length <= 0 and @current
      popup = new di.views.PopupView(model: menu, x: @$('.animal').offset().left, y: @$('.animal').offset().top, index: index, ring: this, color: @current.color)
      @trigger 'popup:change'
      @popups.push popup
      @flip @lastAngle
      $(".popups .site#{@current.id}").append popup.render()
  addPopup: (popup)->
    @trigger 'popup:change'
    @popups.push popup
  removePopup: (popup)->
    @trigger 'popup:change'
    @popups = _.without @popups, popup
  gatherPopups: ->
    if @current
      for popup in @popups
        popup.resetPosition()
  closePopups: ->
    for popup in @popups
      popup.dispose()
    if @current
      $(".popups .site#{@current.id}").fadeOut(-> $(this).remove())
    @popups = []
  rotate: ->
    if @current
      $(".popups .site#{@current.id} .popup").css transform: ''
    if @rotated
      $(".popups .site#{@current.id}").addClass('animated') if @current
      $(".popups .site#{@current.id}").removeClass('upsidedown') if @current
      @$('.offset').css transform: 'rotate(0)'
      @lastAngle = 0
      @rotated = false
    else
      @lastAngle = 180
      $(".popups .site#{@current.id}").addClass('animated') if @current
      $(".popups .site#{@current.id}").addClass('upsidedown') if @current
      @$('.offset').css transform: 'rotate(180)'
      @rotated = true
  flip: (degrees)->
    #a = degrees * (Math.PI / 180)
    if @current and degrees == 180
      @rotated = true
      $(".popups .site#{@current.id}").addClass('upsidedown') if @current
      ###
      if a > 1
        if !@upsideDown
          console.log "flip down: #{a}"
          @upsideDown = true
          $(".popups .site#{@current.id} .popup").transition
            'transform': 'translate(0, 0) rotate(180deg)'
          setTimeout =>
            $(".popups .site#{@current.id}").addClass('upsidedown') if @current
          , 1000
      else if @upsideDown
        console.log "flip up: #{a}"
        @upsideDown = false
        $(".popups .site#{@current.id} .popup").transition
          'transform': 'translate(0, 0) rotate(0deg)'
        setTimeout =>
          $(".popups .site#{@current.id}").removeClass('upsidedown') if @current
        , 1000
        ###
  bringToTop: (e)->
    topZ = 0
    $('.ring').each ->
      thisZ = parseInt $(this).css('zIndex'), 10
      if thisZ > topZ
        topZ = thisZ
    @$el.css('zIndex', topZ+1)
