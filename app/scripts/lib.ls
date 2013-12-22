# Expose prelude globally:
window <<< b-require 'prelude-ls'


### Polyfills! ###

# performance.now:
unless window.performance?.now? then window.performance = do ->
  start = Date.now!

  {
    now: -> Date.now! - start
  }

# request animation frame:
window.request-animation-frame =
  window.request-animation-frame or
  window.moz-request-animation-frame or
  window.webkit-request-animation-frame or
  window.ms-request-animation-frame or
  (cb) -> set-timeout cb, 16
