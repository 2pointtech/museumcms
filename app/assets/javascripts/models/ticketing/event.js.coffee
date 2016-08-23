class di.models.Event extends Backbone.Model
  general: ->
    @get('type') == 'Ticketing::GeneralEvent'
  program: ->
    @get('type') == 'Ticketing::Program'
  exhibit: ->
    @get('type') == 'Ticketing::Exhibit'


class di.models.Events extends Backbone.Collection
  model: di.models.Event
  url: '/ticketing/events.json'
  general: ->
    new di.models.Tickets(@filter (m)-> m.get('type') == 'Ticketing::GeneralEvent')
  programs: ->
    new di.models.Tickets(@filter (m)-> m.get('type') == 'Ticketing::Program')
  exhibits: ->
    new di.models.Tickets(@filter (m)-> m.get('type') == 'Ticketing::Exhibit')
