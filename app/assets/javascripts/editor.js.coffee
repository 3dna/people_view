initEditor = ()->
  $input = $('input[name="api[body]"]')
  return unless $input.length > 0

  editor  = ace.edit "editor"
  session = editor.getSession()

  editor.setTheme("ace/theme/solarized_light")
  session.setMode("ace/mode/json")

  editor.setValue $input.val()

  session.on 'change', ()->
    $input.val editor.getValue()


$ ()->
  initEditor()
