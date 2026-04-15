local lint = require 'lint'

-- Configure golangci-lint for Go files
lint.linters_by_ft = {
  go = { 'golangcilint' },
}

-- Create an autocommand to trigger linting on save and on entering a buffer
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
