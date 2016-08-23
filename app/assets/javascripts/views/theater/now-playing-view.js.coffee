class di.views.NowPlayingView extends Backbone.View
  tagName: 'article'
  className: 'now-playing'
  initialize: (@options)->
    @nowTitle = @options.nowTitle || 'NOW PLAYING'
    @nextTitle = @options.nextTitle || 'NEXT UP'
    @countdownTitle = @options.countdownTitle || 'PLAYING IN'
    @timerTitle = @options.timerTitle || 'TIME REMAINING'

    @$el.html JST['theater/now-playing']
    @current = @collection.current()
    setInterval =>
      @update()
    , 1000
  render: ->
    if @current
      @$('.title h1').html @current.get('title')
      @$('.title h3').html @current.get('category')
      @update()
    else
      @$('.title h2').html ''
    @$el
  update: ->
    current = @collection.current()
    return unless current

    if @current and current.get('title') == @current.get('title')
      now = new Date().getTime()
      time = @current.when().getTime()
      length = parseInt(@current.length())
      delta = now - time
      if delta > 0
        @$('.time-remaining .minute').html Math.abs(util.tom(length - delta))
        @$('.time-remaining .seconds').html Math.abs(util.tos(length - delta))
        $('.title h2').html @nowTitle + ':'
        $('.time-remaining h3').html @timerTitle + ':'
      else
        delta = time - now
        @$('.time-remaining .minute').html Math.abs(util.tom(delta))
        @$('.time-remaining .seconds').html Math.abs(util.tos(delta))
        $('.title h2').html @nextTitle + ':'
        $('.time-remaining h3').html @countdownTitle + ':'
    else
      @current = current
      @render()
      $('.upcoming-list div:first-child').fadeOut ->
        $(this).remove()
