require('daavsnts.set')
require('daavsnts.remap')
require('daavsnts.lazy_init')
require('daavsnts.customcmds')

vim.filetype.add({
  extension = {
    ['component.html'] = 'htmlangular',
  },
  pattern = {
    ['.*%.component%.html'] = 'htmlangular',
  },
})
