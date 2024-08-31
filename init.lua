vim.cmd('source ~/.config/init.vim')
-- Mason
require("mason").setup()
require("sol")

_G.toggle_color_scheme = function(color_scheme)
    if color_scheme == "sol" then
        vim.cmd("colorscheme solarized")
        vim.cmd("set background=light")
    end
end

vim.api.nvim_set_keymap('n', '<leader>tc', ':lua toggle_color_scheme(vim.fn.input("Enter color scheme:  "))<CR>', { noremap = true, silent = true })

local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  port = "13001",
  executable = {
    -- CHANGE THIS to your path!
    command = '/Users/sreepathyjayanand/Documents/utils/dap/adapter/codelldb',
    -- command = '/Users/sreepathyjayanand/.local/share/nvim/mason/bin/codelldb',
    args = {"--port", "13001"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    stdio = 'input.txt',
  },
}
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end)
vim.keymap.set('n', '<C-I>', '<C-I>')
