class di.views.SaverView extends Backbone.View
  id: 'saver_view'
  initialize: ()->
  render: ->
    @$el.html '<video loop="loop"><source></video>'
    @$('video source').attr src: '/videos/attract.webm'
    @$('video').one 'click', (e)=>
      @stop()
    background = @$('video')[0]
    background.play()
    $.idleTimer('destroy')
    @$el
  start: ->
    $.idleTimer(160000)
    $(document).bind "idle.idleTimer", =>
      $(document).trigger 'saver:started'
      di.router.navigate '/', trigger: true
      $(document.body).append @render()
  stop: ->
    @$el.transition
      y: -1080
      complete: =>
        @$el.css y: 0
        @$('video')[0].pause()
        @$('video').attr src: ''
        @$('video source').attr src: ''
        @remove()
        @start()

