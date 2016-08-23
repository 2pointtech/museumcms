class di.views.DonorPopupView extends Backbone.View
  className: 'donor-popup'
  events: 
    'click .close': 'close'
  initialize: (@options = {}) ->
  render: ->
    @$el.html JST['donors/donor-popup']
    @$('img').attr src: @model.get('photo').url
    @$('h2').html(@model.get('name')).hide()
    @$('p').html(@model.get('description')).hide()
    @$('.close').hide()

    @$('img').css
      opacity: 0

    setTimeout =>
      @originalPosition = [@$('img').position().top, @$('img').position().left, @$('img').width()]
      console.log @originalPosition
      @$('img').css
        position: 'absolute'
        top: @options.img.offset().top
        left: @options.img.offset().left
        width: @options.img.width()
        opacity: 1

      @$el.show()
      @$('img').transition
        top: @originalPosition[0]
        left: @originalPosition[1]
        width: @originalPosition[2]
      setTimeout =>
        @$('img').attr style: ''
        @$('h2').fadeIn()
        @$('p').fadeIn()
        @$('.close').fadeIn()
      , 500
      $('.main').addClass('popup-open')
    , 100
    @$el
  close: ->
    @$el.fadeOut =>
      @remove()
      @options.closed()
      $('.main').removeClass('popup-open')
