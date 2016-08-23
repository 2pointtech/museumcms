class di.models.Movie extends Backbone.Model
  when: ->
    now = new Date()
    time = new Date(@get('when'))
    time.setDate(now.getDate())
    time.setFullYear(now.getFullYear())
    time.setMonth(now.getMonth())
    time
  length: ->
    @get('length') * 1000

class di.models.Movies extends Backbone.Collection
  initialize: ->
    this.on 'sync', ->
      for movie in this.sortBy('row')
        unless start
          start = if movie.get('auto_play') then new Date() else movie.when()
        if movie.get('auto_play')
          movie.set('when', currentTime)

        currentTime = movie.when().getTime() + (movie.get('length') * 1000)
      this.sort()
  comparator: (m)-> m.when()
  url: '/theater/showings.json'
  model: di.models.Movie
  current: ->
    now = new Date().getTime()
    @find (m)->
      m.when().getTime() + m.length() >= now
