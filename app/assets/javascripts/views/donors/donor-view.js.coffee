class di.views.DonorView extends Backbone.View
  className: 'donor'
  events: 
    'click': 'open'
  initialize: (@options = {}) ->
  render: ->
    @$el.html JST['donors/donor']
    @$('img').attr src: @model.get('photo').url
    @$('h2').html @model.get('name')
    @$('p').html @model.get('description')
    @$el
  open: ->
    @options.parent.stop()
    popupView = new di.views.DonorPopupView
      model: @model, img: @$('img'), closed: =>
        @options.parent.start()
    $(document.body).append popupView.render()
