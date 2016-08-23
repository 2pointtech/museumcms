class di.views.UpcomingListView extends Backbone.View
  tagName: 'article'
  className: 'upcoming-list'
  initialize: ->
    @collection.on 'sync', => @render()
  render: ->
    @$el.empty()
    now = new Date().getTime()
    for model in @collection.filter((m)-> m.when().getTime() > now)
      @$el.append new di.views.UpcomingItemView(model: model).render()
    @$el
