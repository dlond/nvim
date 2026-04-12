vim.pack.add({ "https://codeberg.org/mfussenegger/nvim-dap.git" })

local dap = require("dap")

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

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
