class di.views.UpcomingItemView extends Backbone.View
  className: "col-md-12 listing"
  render: ->
    @$el.html JST['theater/upcoming-item']
    @$('.title').html @model.get('title')
    @$('.type').html @model.get('category')
    @$('.minute').html util.tom(@model.length())
    @$('.seconds').html util.tos(@model.length())
    @$('.time').html moment(@model.when()).format 'h:mma'
    @$el
