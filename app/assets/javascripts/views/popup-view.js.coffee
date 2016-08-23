class di.views.PopupView extends Backbone.View
  events:
    'touchstart .close': 'dispose'
    'touchend': 'bringToTop'
  initialize: (@options)->
    @moving = false
    @ring = @options.ring
  className: 'popup-wrapper'
  render: ->
    @$el.html JST["popup"]
    @$el.css opacity: 0
    @$('.popup').css
      backgroundColor: @options.color
    @$('h1').html @model.title
    @$el.attr id: "popup#{@model.id}"
    @$el.addClass "index#{@options.index}"
    if @model.type == 'Table::MediaMenu'
      @$el.addClass 'media-menu'
      @populateMedia()
      @dragEvents()
    else if @model.type == 'Table::TextMenu'
      @$el.addClass 'text'
      @$('.body > div').html @model.content
      @dragEvents()
      @wrapPhotos()
    else
      @$el.attr id: "popup-media#{@model.id}"
      if @isVideo(@model.file.url)
        player = new di.views.PlayerView model: @model
        @$el.addClass 'video'
        @$('.body').html player.render()
        @$('.body video')[0].play()
        @$('h1').html 'Video'
      else
        @$el.addClass 'photo'
        @$('.body').html $('<img>').attr(src: @model.file.url)
        @$('h1').html 'Photo'
      @$('.body').append $('<p>').html(util.simpleFormat(@model.caption)) if @model.caption
      @dragEvents()
    setTimeout =>
      @calcCoords()
      @move  @startX, @startY
      @$el.hide()
      @$el.css opacity: 1
      @$el.fadeIn()
      @bringToTop()
    , 100
    @$el
  move: (x, y, animate = false)->
    x = 0 if x < 0
    deltaY = (y + @$('.popup').outerHeight()) - $('.map').height()
    y -= deltaY if deltaY > 0
    y = 0 if y < 0
    deltaX = (x + @$('.popup').outerWidth()) - $('.map').width()
    x -= deltaX if deltaX > 0
    if animate
      @$el.transition
        left: x
        top: y
      @$('.popup').transition
        scale: 1
        rotate: if @$el.closest('.upsidedown').length != 0 then "180deg" else "0deg"
    else
      @$el.css
        left: x
        top: y
  dispose: ()->
    @$el.fadeOut =>
      @$('video').each -> this.pause()
      @$('video').attr src: ''
      @$('video source').attr src: ''
      @remove()
      @ring.removePopup this
      
    moveSelector = if @model.type == 'Table::TextMenu' then '.popup h1' else '.popup'
  bringToTop: (e)->
    topZ = 0
    $('.popup-wrapper').each ->
      thisZ = parseInt $(this).css('zIndex'), 10
      if thisZ > topZ
        topZ = thisZ
    @$el.css('zIndex', topZ+1)

  populateMedia: ->
    for medium in @model.media
      do (medium)=>
        url = medium.file.url
        thumb = $('<div>').addClass('thumb')
        if @isVideo(url)
          video = $('<video>').html($('<source>').attr(src: medium.file.url + '?thumb'))
          thumb.html video
          video.on 'canplay', ->
            this.currentTime = 1
          video.each ->
            this.load()
        else
          thumb.html $('<img>').attr src: medium.file.url
        thumb.on 'touchend', (e)=>
          e.stopPropagation()
          medium.site_id = @model.site_id
          unless $(".popups .site#{@model.site_id} #popup-media#{medium.id}").length > 0
            popup = new di.views.PopupView(model: medium, x: @options.x, y: @options.y, index: @options.index, ring: @ring, color: @options.color)
            $(".popups .site#{@model.site_id}").append popup.render()
            popup.bringToTop()
            @ring.addPopup popup
        @$('.body').append thumb

  isVideo: (o)->
    o.match('(.mp4|.m4v|.webm)$')
  dragEvents: ->
    position = null
    rotation = 0
    scale = 1
    last_scale = 1

    mc = new Hammer(@el)
    mc.get('rotate').set({ enable: true })
    mc.get('pinch').set({ enable: true })

    mc.on 'panstart rotatestart', (ev)=>
      console.log "Start"
      position = @$el.offset()
      rotation = @$('.popup').rotationDegrees()
      @bringToTop()
      last_scale = scale

    mc.on 'panmove', (ev)=>
      console.log "Move"
      requestAnimationFrame =>
        @move position.left + ev.deltaX, position.top + ev.deltaY

    unless @model.type
      mc.on 'pinch rotate', (ev)=>
        if ev.pointers.length >= 2
          scale = Math.max(1, Math.min(last_scale * ev.scale, 2))

          @$('.popup').css
            transform: "scale("+scale+","+scale+") " + "rotate("+(rotation + ev.rotation)+"deg) "
    else
      mc.on 'pinch', (ev)=>
        if ev.pointers.length >= 2
          scale = Math.max(1, Math.min(last_scale * ev.scale, 2))
          @$('.popup').css
            transform: "scale("+scale+","+scale+") " + "rotate("+(rotation)+"deg) "

    setTimeout =>
      if @model.type == 'Table::TextMenu'
        @$el.scrollbar(parentHammer: mc)

    , 100


  wrapPhotos: ->
    for img in @$('.body img')
      do (img)=>
        clone = $(img).clone()
        icon = $('<span>').addClass('dp open').html('&#61477;')
        $(img).replaceWith $('<div>').addClass('img-wrapper').html(clone).append(icon)
        icon.on 'touchend', =>
          popup = new di.views.PopupView(model: { file: { url: clone.attr('src') }, site_id: @model.site_id }, x: @options.x, y: @options.y, index: @options.index, ring: @ring, color: @options.color)
          $(".popups .site#{@model.site_id}").append popup.render()
          popup.bringToTop()
          @ring.addPopup popup

  calcCoords: ->
    ringWidth = 200
    popupWidth = @$('.popup').outerWidth()
    popups = $(".popups .site#{@model.site_id} .popup-wrapper")
    count = popups.length
    if count > 1
      last = $(popups[popups.length - 2])
      @startX = last.position().left
      @startY = last.position().top
    else
      @startX = @options.x + ringWidth
      @startY = @options.y

    count = $(".popups .site#{@model.site_id} .popup").length
    @startX += 30 
    @startY += 30

    if (@options.x > $(document).width() / 2)
      @startX = @options.x - popupWidth - 100
      @startX -= 30

  resetPosition: ->
    @move  @startX, @startY, true
