require! {
  'views/main-menu'
  'lib'
}

app = $ '#container'

# Set up the main-menu
menu = app.find '.main-menu' |> main-menu

menu.on 'play' ->
  menu.trigger 'destroy'

