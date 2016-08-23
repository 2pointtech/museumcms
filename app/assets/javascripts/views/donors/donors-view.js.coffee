class di.views.DonorsView extends Backbone.View
  render: ->
    @currentIndex = 0
    @start()
    @showNext()
    @$el
  showNext: =>
    container = $('<div>').addClass('donor-container')
    for model in @collection.sortBy('name')
      donorView = new di.views.DonorView(model: model, parent: @)
      container.append donorView.render()
    @$el.prepend container
    container.hide()
    container.css 
      display: 'block'
      top: -container.height()
  scroll: =>
    height = $('.donors').outerHeight()

    first = @$('.donor-container:first-child')
    if first.length > 0 and first.position().top > 0
      @showNext()

    @$('.donor-container').each ()->
      position =  $(this).position().top + 1
      console.log position
      console.log height
      if position > height
        $(this).remove()
      $(this).css 
        top: $(this).position().top + 1


  start: ->
    @timer = setInterval @scroll, 10
  stop: ->
    clearInterval @timer
