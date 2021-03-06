require! 'game/mediator'

actions = {
  kill: (player) ->
    player.fall-to-death!

  spike: (player) -> actions.kill player
}

# Hyperlinks
mediator.on 'begin-contact:HYPERLINK:ENTITY_PLAYER' (contact) ->

  speed = contact.b.last-v.y
  if 3.5px < speed < 10px then window.location.href = contact.a.el.href

# Portals
mediator.on 'begin-contact:PORTAL:ENTITY_PLAYER' (contact) ->
  <- set-timeout _, 250

  if contact.b.last-fall-dist > 200px then return

  contact.b
    ..frozen = true
    ..handle-input = false
    ..classes-disabled = true

  contact.b.el.class-list.add 'portal-out'
  contact.a.el.class-list.add 'portal-out'

  <- set-timeout _, 750
  window.location.href = contact.a.el.href

# Falling to death, actions:
mediator.on 'begin-contact:ENTITY_PLAYER:*' (contact) ->
  console.log contact.a.last-fall-dist

  # First, check for and trigger actions
  if contact.b.data?.action?
    action = contact.b.data.action
    console.log 'ACTION' action
    if actions[action]?
      actions[action] contact.a, contact.b

  if contact.a.last-fall-dist > 300px and not contact.b.data?.sensor?
    mediator.trigger 'fall-to-death'

# Kitten finding
mediator.on 'begin-contact:ENTITY_TARGET:ENTITY_PLAYER' (contact) ->
  target = contact.a

  target.destroy!

  unless target.destroyed
    mediator.trigger 'kittenfound'

  target.destroyed = true

  $el = $ target.el

  $el.one prefixed.animation-end, -> $el.remove!

  $el.add-class 'found'

