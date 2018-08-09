# initialize your global object will all your model names
window.GymcloudAdmin = GymcloudAdmin =
  program_presets: {}

jQuery(document).ready ($) ->
  # get the page action
  action = undefined
  model = undefined
  b = $('body')
  if b.hasClass('edit')
    action = 'edit'
  else if b.hasClass('view')
    action = 'view'
  else if b.hasClass('index')
    action = 'index'
  else if b.hasClass('new')
    action = 'new'
  # run the code specific to a model and an action
  for m of GymcloudAdmin
    if b.hasClass('admin_' + m)
      pageAction = GymcloudAdmin[m][action]
      if pageAction and typeof pageAction == 'function'
        pageAction()
        break
