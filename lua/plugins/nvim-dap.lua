vim.pack.add({
  "https://codeberg.org/mfussenegger/nvim-dap.git",
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
})

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.adapters["lldb-dap"] = {
  type = "executable",
  command = vim.fn.exepath("lldb-dap"),
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "lldb-dap",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
  {
    name = "Attach to process",
    type = "lldb-dap",
    request = "attach",
    pid = function()
      return require("dap.utils").pick_process()
    end,
  },
}

dap.configurations.cpp = dap.configurations.c

dap.adapters["debugpy"] = function(cb, config)
  if config.request == "attach" then
    local port = (config.connect or config).port
    local host = (config.connect or config).host or "127.0.0.1"
    cb({
      type = "server",
      port = assert(port, "`connect.port` is required for a python `attach` configuration"),
      host = host,
      options = {
        source_filename = "python",
      },
    })
  else
    cb({
      type = "executable",
      command = vim.fn.exepath("python"),
      args = { "-m", "debugpy.adapter" },
      options = {
        source_filetype = "python",
      },
    })
  end
end

dap.configurations.python = {
  {
  type = "debugpy";
  request = "launch";
  name = "Launch file";

  program = "${file}";
  pythonPath = vim.fn.exepath("python");
},
}


vim.keymap.set("n", "<leader>dg", [[<Cmd>DapNew<CR>]], { desc = "Start debugging" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Eval expression" })
