class di.models.Ticket extends Backbone.Model
class di.models.Tickets extends Backbone.Collection
  model: di.models.Ticket
  url: '/ticketing/tickets.json'
  general: ->
    new di.models.Tickets(@filter (m)-> m.get('type') == 'Ticketing::GeneralTicket')
  memberships: ->
    new di.models.Tickets(@filter (m)-> m.get('type') == 'Ticketing::Membership')
