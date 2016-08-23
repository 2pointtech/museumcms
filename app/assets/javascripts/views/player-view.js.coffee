class di.views.PlayerView extends Backbone.View
  className: 'player'
  render: ->
    @$el.html JST['player']
    @$('video source')[0].src = @model.file.url + "?fresh"
    @$('video').on 'timeupdate', ->
      try
        $.idleTimer('ping')

    @$el.on 'touchstart touchend', (e)->
      e.stopPropagation()

    video = @$('video')[0]
    @$('.play').on 'touchend', ->
      if video.paused
        video.play()
      else
        video.pause()
    @$('video').on 'play', =>
      @$('.play').html '&#61543;'
    @$('video').on 'pause', =>
      @$('.play').html '&#61542;'
    @$('video').on 'timeupdate', =>
      value = (100 / video.duration) * video.currentTime
      @$('.seek input').val value
      @$('.current').html "#{Math.floor(video.currentTime / 60).pad(2)}:#{Math.ceil(video.currentTime % 60).pad(2)}"

      @$('.total').html "#{Math.floor(video.duration / 60).pad(2)}:#{Math.ceil(video.duration % 60).pad(2)}"

    @$('.seek input').on "input", ()->
      time = video.duration * ($(this).val() / 100)

      video.currentTime = time
    @$el
