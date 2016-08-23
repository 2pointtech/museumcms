class di.routers.DefaultRouter extends Backbone.Router
  initialize: ->
    @overlay = new di.views.OverlayView()
    $('.page').append @overlay.render()
    @map = new di.views.MapView()
    $('.page').append @map.render()

    $.idleTimer(160000)
    $(document).bind "idle.idleTimer", =>
      if $('.page .overlay').length == 0
        @overlay = new di.views.OverlayView()
        $('.page').append @overlay.render()
        @map.reset()
  routes:
    '': 'home'

  home: ->
