class di.views.HelpView extends Backbone.View
  events:
    'touchend .close': 'toggle'
    'touchend .button': 'toggle'
  initialize: (@options = {})->
    if @options.rotate
      @$el.addClass 'rotate'
  className: 'help closed'
  render: ->
    @$el.html JST["help"]
    @$el
  toggle: ->
    @$el.toggleClass 'closed'
