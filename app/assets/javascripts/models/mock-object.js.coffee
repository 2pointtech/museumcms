class di.models.MockObject
  initialize: (@x, @y, @a, @sessionId)->
  getScreenX: ->
    @x
  getScreenY: ->
    @y
  getAngle: ->
    @a
  getSessionId: ->
    @sessionId
