class di.views.TheaterPlayerView extends Backbone.View
  className: 'theater-player'
  initialize: (@options)->
    setInterval =>
      @update()
    , 1000
  render: ->
    @$el.html($('<video>').html($('<source>')))
    @update()
    @$el
  update: ->
    current = @collection.current()
    
    if !@current or current.id != @current.id
      if current and current.when().getTime() < new Date().getTime()
        @current = current
        url = if @current.get('existing_video') then @current.get('existing_video').file.url else @current.get('video').url
        if url
          @$('video').attr src: url
          @$('video source').attr src: url
          @$('video').on 'canplay', ->
            $(this).show()
          @$('video').on 'ended', ->
            $(this).hide()
            $(this).attr src: ''
            $(this).find('source').attr src: ''
          @$('video').show()
          @$('video').each -> this.play()
