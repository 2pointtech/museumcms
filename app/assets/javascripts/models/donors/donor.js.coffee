class di.models.Donor extends Backbone.Model

class di.models.Donors extends Backbone.Collection
  url: '/donors/donors.json'
  model: di.models.Donor
