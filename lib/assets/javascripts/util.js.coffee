window.util =
  simpleFormat: (s)->
    s.replace /[\n\r]+/g, '<br>'
  tom: (mil)->
    Math.floor(mil / 1000 / 60) 
  tos: (mil)->
    Math.floor(mil / 1000) % 60

Number.prototype.pad = (size)->
  if typeof(size) != "number"
    size = 2
  s = String(this)
  s = "0" + s while (s.length < size)
  return s
