class di.views.MapView extends Backbone.View
  initialize: ->
    Hammer.defaults.touchAction = 'none';

    @screenW = $(document).width()
    @screenH = $(document).height()
    @symbols = [1]

  className: 'map'
  render: ->
    @renderRings()
    @$el.append new di.views.HelpView().render()
    @$el.append new di.views.HelpView(rotate: true).render()

    back = $('<button>').addClass('back').html('back')
    back.click ->
      @overlay = new di.views.OverlayView()
      $('.page').append @overlay.render()
      @reset()
    @$el.append back

    @$el

  renderRings: ->
    @rings = []

    index = 0
    for i in [0..0]
      ring = new di.views.RingView(sessionId: index++, x: (i * 300) + 1600, y: 700, a: 0)
      @$el.append ring.render()
      @bindEvents ring
      @rings.push ring
    for i in [0..0]
      ring = new di.views.RingView(sessionId: index++, x: (i * 300), y: 100, a: 180)
      @$el.append ring.render()
      @bindEvents ring
      @rings.push ring

  reset: ->
    @mc.destroy()
    for ring in @rings
      ring.dispose()
    @renderRings()

  bindEvents: (ring)->
    handle = ring.$('.move-handle')
    @mc = new Hammer(handle[0])
    position = null
    rotation = 0

    ###
    @mc.get('rotate').set({ enable: true })
    @mc.on 'rotatemove', (ev)=>
      ring.update position.left, position.top, rotation + ev.rotation
    ###

    @mc.on 'panstart rotatestart', (ev)=>
      position = $(ev.target).closest('.ring').offset()
      #rotation = $(ev.target).closest('.offset').rotationDegrees()


    @mc.on 'panmove', (ev)=>
      ring.update position.left + ev.deltaX, position.top + ev.deltaY


