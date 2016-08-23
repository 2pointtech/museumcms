class di.models.classroom.Event extends Backbone.Model
  when: ->
    new Date(@get('when'))
  length: ->
    @get('length') * 1000

class di.models.classroom.Events extends Backbone.Collection
  comparator: 'when'
  url: ->
    "/classroom/schedules/#{@scheduleId}.json"
  model: di.models.classroom.Event
  current: ->
    now = new Date().getTime()
    @find (m)->
      m.when().getTime() + m.length() >= now
