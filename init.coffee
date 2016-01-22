# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

fs = require('fs')


atom.workspace.observeTextEditors (editor) ->

  try
    filePath = editor.getPath()
  catch error
    return
  return unless fs.existsSync(filePath)

  jschardet = require 'jschardet'
  iconv = require 'iconv-lite'

  fs.readFile filePath, (error, buffer) ->
    return if error?
    {encoding} = jschardet.detect(buffer) ? {}
    encoding = 'utf8' if encoding is 'ascii' or encoding is 'windows-1252'
    encoding = 'euc-jp' if encoding is 'EUC-KR'
    return unless iconv.encodingExists(encoding)

    encoding = encoding.toLowerCase().replace(/[^0-9a-z]|:\d{4}$/g, '')
    editor.setEncoding(encoding)

  editor.scan /[\x00-\x08\x0b\x0c\x0e-\x1f]/g, ({stop}) ->
    atom.notifications.addWarning "replace CtrlCode"

  editor.scan /\x00/g, ({replace}) ->
    replace("^@")
  editor.scan /\x01/g, ({replace}) ->
    replace("^A")
  editor.scan /\x02/g, ({replace}) ->
    replace("^B")
  editor.scan /\x03/g, ({replace}) ->
    replace("^C")
  editor.scan /\x04/g, ({replace}) ->
    replace("^D")
  editor.scan /\x05/g, ({replace}) ->
    replace("^E")
  editor.scan /\x06/g, ({replace}) ->
    replace("^F")
  editor.scan /\x07/g, ({replace}) ->
    replace("^G")
  editor.scan /\x08/g, ({replace}) ->
    replace("^H")
  # editor.scan /\x09/g, ({replace}) ->
  #   replace("^I")
  # editor.scan /\x0A/g, ({replace}) ->
  #   replace("^J")
  editor.scan /\x0B/g, ({replace}) ->
    replace("^K")
  editor.scan /\x0C/g, ({replace}) ->
    replace("^L")
  # editor.scan /\x0D/g, ({replace}) ->
  #   replace("^M")
  editor.scan /\x0E/g, ({replace}) ->
    replace("^N")
  editor.scan /\x0F/g, ({replace}) ->
    replace("^O")
  editor.scan /\x10/g, ({replace}) ->
    replace("^P")
  editor.scan /\x11/g, ({replace}) ->
    replace("^Q")
  editor.scan /\x12/g, ({replace}) ->
    replace("^R")
  editor.scan /\x13/g, ({replace}) ->
    replace("^S")
  editor.scan /\x14/g, ({replace}) ->
    replace("^T")
  editor.scan /\x15/g, ({replace}) ->
    replace("^U")
  editor.scan /\x16/g, ({replace}) ->
    replace("^V")
  editor.scan /\x17/g, ({replace}) ->
    replace("^W")
  editor.scan /\x18/g, ({replace}) ->
    replace("^X")
  editor.scan /\x19/g, ({replace}) ->
    replace("^Y")
  editor.scan /\x1A/g, ({replace}) ->
    replace("^Z")
  editor.scan /\x1B/g, ({replace}) ->
    replace("^[")
  editor.scan /\x1C/g, ({replace}) ->
    replace("^\\")
  editor.scan /\x1D/g, ({replace}) ->
    replace("^]")
  editor.scan /\x1E/g, ({replace}) ->
    replace("^^")
  editor.scan /\x1F/g, ({replace}) ->
    replace("^_")

  return
