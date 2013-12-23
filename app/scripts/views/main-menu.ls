module.exports = (el) ->
  events = new Events!

  el.on 'click', 'button.play', -> events.trigger 'play'

  events.on 'destroy', ->
    events.off!
    el.empty!

  events
