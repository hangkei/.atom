# # Your init script
# #
# # Atom will evaluate this file each time a new window is opened. It is run
# # after packages are loaded/activated and after the previous editor state
# # has been restored.
# #
# # An example hack to log to the console when each text editor is saved.
# #
# # atom.workspace.observeTextEditors (editor) ->
# #   editor.onDidSave ->
# #     console.log "Saved! #{editor.getPath()}"
# 
# #atom.workspace.onDidOpen ->
# #  editor = atom.workspace.getActiveTextEditor()
# 
# atom.workspace.observeTextEditors (editor) ->
# 
#   fs = require 'fs'
#   try
#     filePath = editor.getPath()
#   catch error
#     return
#   return unless fs.existsSync(filePath)
# 
#   {detect} = require 'jschardet'
#   {encodingExists} = require 'iconv-lite'
# 
#   fs.readFile filePath, (error, buffer) ->
#     return if error?
#     {encoding} = detect buffer ? {}
#     encoding = 'utf8' if encoding is 'ascii' or encoding is 'windows-1252'
#     encoding = 'euc-jp' if encoding is 'EUC-KR'
#     return unless encodingExists encoding
# 
#     atom.notifications.addInfo encoding, detail:editor.getTitle() if encoding isnt 'utf8'
#     encoding = encoding.toLowerCase().replace(/[^0-9a-z]|:\d{4}$/g, '')
#     editor.setEncoding(encoding)
# 
#   # editor.scan /[\x00-\x08\x0b\x0c\x0e-\x1f]/g, ({stop}) ->
#   #   atom.notifications.addWarning "replace CtrlCode"
# 
#   editor.scan /\x00/g, ({replace}) ->
#     replace "^@"
#     atom.notifications.addWarning "replace CtrlCode ^@"
#   editor.scan /\x01/g, ({replace}) ->
#     replace "^A"
#     atom.notifications.addWarning "replace CtrlCode ^A"
#   editor.scan /\x02/g, ({replace}) ->
#     replace "^B"
#     atom.notifications.addWarning "replace CtrlCode ^B"
#   editor.scan /\x03/g, ({replace}) ->
#     replace "^C"
#     atom.notifications.addWarning "replace CtrlCode ^C"
#   editor.scan /\x04/g, ({replace}) ->
#     replace "^D"
#     atom.notifications.addWarning "replace CtrlCode ^D"
#   editor.scan /\x05/g, ({replace}) ->
#     replace "^E"
#     atom.notifications.addWarning "replace CtrlCode ^E"
#   editor.scan /\x06/g, ({replace}) ->
#     replace "^F"
#     atom.notifications.addWarning "replace CtrlCode ^F"
#   editor.scan /\x07/g, ({replace}) ->
#     replace "^G"
#     atom.notifications.addWarning "replace CtrlCode ^G"
#   editor.scan /\x08/g, ({replace}) ->
#     replace "^H"
#     atom.notifications.addWarning "replace CtrlCode ^H"
#   # editor.scan /\x09/g, ({replace}) ->
#   #   replace "^I"
#     # atom.notifications.addWarning "replace CtrlCode ^I"
#   # editor.scan /\x0A/g, ({replace}) ->
#   #   replace "^J"
#     # atom.notifications.addWarning "replace CtrlCode ^J"
#   editor.scan /\x0B/g, ({replace}) ->
#     replace "^K"
#     atom.notifications.addWarning "replace CtrlCode ^K"
#   editor.scan /\x0C/g, ({replace}) ->
#     replace "^L"
#     atom.notifications.addWarning "replace CtrlCode ^L"
#   # editor.scan /\x0D/g, ({replace}) ->
#   #   replace "^M"
#     # atom.notifications.addWarning "replace CtrlCode ^M"
#   editor.scan /\x0E/g, ({replace}) ->
#     replace "^N"
#     atom.notifications.addWarning "replace CtrlCode ^N"
#   editor.scan /\x0F/g, ({replace}) ->
#     replace "^O"
#     atom.notifications.addWarning "replace CtrlCode ^O"
#   editor.scan /\x10/g, ({replace}) ->
#     replace "^P"
#     atom.notifications.addWarning "replace CtrlCode ^P"
#   editor.scan /\x11/g, ({replace}) ->
#     replace "^Q"
#     atom.notifications.addWarning "replace CtrlCode ^Q"
#   editor.scan /\x12/g, ({replace}) ->
#     replace "^R"
#     atom.notifications.addWarning "replace CtrlCode ^R"
#   editor.scan /\x13/g, ({replace}) ->
#     replace "^S"
#     atom.notifications.addWarning "replace CtrlCode ^S"
#   editor.scan /\x14/g, ({replace}) ->
#     replace "^T"
#     atom.notifications.addWarning "replace CtrlCode ^T"
#   editor.scan /\x15/g, ({replace}) ->
#     replace "^U"
#     atom.notifications.addWarning "replace CtrlCode ^U"
#   editor.scan /\x16/g, ({replace}) ->
#     replace "^V"
#     atom.notifications.addWarning "replace CtrlCode ^V"
#   editor.scan /\x17/g, ({replace}) ->
#     replace "^W"
#     atom.notifications.addWarning "replace CtrlCode ^W"
#   editor.scan /\x18/g, ({replace}) ->
#     replace "^X"
#     atom.notifications.addWarning "replace CtrlCode ^X"
#   editor.scan /\x19/g, ({replace}) ->
#     replace "^Y"
#     atom.notifications.addWarning "replace CtrlCode ^Y"
#   editor.scan /\x1A/g, ({replace}) ->
#     replace "^Z"
#     atom.notifications.addWarning "replace CtrlCode ^Z"
#   editor.scan /\x1B/g, ({replace}) ->
#     replace "^["
#     atom.notifications.addWarning "replace CtrlCode ^["
#   editor.scan /\x1C/g, ({replace}) ->
#     replace "^\\"
#     atom.notifications.addWarning "replace CtrlCode ^\\"
#   editor.scan /\x1D/g, ({replace}) ->
#     replace "^]"
#     atom.notifications.addWarning "replace CtrlCode ^]"
#   editor.scan /\x1E/g, ({replace}) ->
#     replace "^^"
#     atom.notifications.addWarning "replace CtrlCode ^^"
#   editor.scan /\x1F/g, ({replace}) ->
#     replace "^_"
#     atom.notifications.addWarning "replace CtrlCode ^_"
# 
#   editor.onDidSave ->
#     encoding = editor.getEncoding()
#     return unless encoding == 'eucjp'
# 
#     editor.buffer.scan /[\uff5e|\u301c]/g, ({stop}) ->
# #      cmd = "nkf -w --overwrite #{filePath};
# #             sed -i -e 's/~/〜/g' #{filePath};
# #             nkf -e --overwrite #{filePath};"
#       cmd = "nkf -w --overwrite #{filePath};
#              nkf -e --overwrite #{filePath};"
#       {exec} = require 'child_process'
#       exec cmd
#   return
