class di.views.OverlayView extends Backbone.View
  events:
    'touchend': 'hide'
  className: 'overlay'
  render: ->
    @$el.html $('<video>').append($('<source>').attr(src: '/videos/roll.webm'))
    @$el.append '<div class="swipe">&lt;&lt; Swipe to Begin</div>'
    xwrapper = $('<div>').addClass 'xwrapper'
    _.each di.sites, (m)=>
      console.log m
      site = $('<div>').addClass('redx').html('&times;').css({ top: m.y, left: m.x })
      description = $('<div>').addClass('map-description').attr(id: "md#{m.id}").html m.map_description
      if m.y > $(window).height() / 2
        description.addClass 'south'
      if m.x > $(window).width() / 2
        description.addClass 'east'
      site.append description
      description.hide()
      xwrapper.append site

      site.on 'touchend', (e)=>
        e.stopPropagation()
        @showSite(m)
        @showDescriptions()
    @$el.append xwrapper
    @showDescriptions()
    @$el
  showDescriptions: ->
    sites = _.filter(di.sites, (s)-> s.map_description)
    current = 0
    clearInterval @timer if @timer
    @timer = setInterval =>
      site = sites[current]

      @showSite(site)

      current++
      current = 0 if current >= sites.length
    , 10000
  showSite: (site)->
    @$('.map-description.open').transition
      scale: 0

    md = @$("#md#{site.id}")
    md.addClass 'open'
    md.css scale: 0, display: 'block'
    md.transition scale: 1

  hide: ->
    clearInterval @timer
    @$('.redx').fadeOut()
    @$('video').on 'ended', =>
      $(this).attr src: ''
      $(this).find('source').attr src: ''
      $(this).remove()
      @remove()
    @$('video')[0].play()

