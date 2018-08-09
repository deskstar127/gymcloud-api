ajax = null
userSelect = null
select = null

template = (record) ->
  "<option value='#{record.id}'>
    [#{record.folder?.name}] #{record.name}
  </option>"

fetchPrograms = ->
  userId = userSelect.val()
  return unless userId
  ajax?.abort?()
  ajax = $.ajax
    type: 'GET'
    url: "/admin/program_presets/user_program_templates"
    data: user_id: userId
    dataType: 'json'
    contentType: 'application/json'
    error: -> ajax = null or console.error(arguments)
    success: (result) ->
      html = result.map(template).join('')
      select.html(html)
      ajax = null

loadProgramTemplates = ->
  userSelect = $('#program_preset_user_id')
  select = $('#program_preset_program_template_ids')
  userSelect.on('change', fetchPrograms)
  fetchPrograms()

window.GymcloudAdmin.program_presets =
  new: loadProgramTemplates
  edit: loadProgramTemplates
