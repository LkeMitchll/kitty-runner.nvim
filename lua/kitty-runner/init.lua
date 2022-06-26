--
-- KITTY RUNNER | INIT
--

local config = require("kitty-runner.config")
local kitty_runner = require("kitty-runner.kitty-runner")

local M = {}

-- setup config
M.setup = function(opts)
  -- update config
  config.update(opts)

  -- setting up commands
  config["define_commands"]()

  -- setting up keymaps
  if config["use_keymaps"] == true then
    config["define_keymaps"]()
  end
end

-- get all functions that we need to run the various commands
for name, command in pairs(kitty_runner) do
  M[name] = command
end

if config["kill_on_quit"] then
  vim.api.nvim_create_augroup("kitty_runner", { clear = true })

  vim.api.nvim_create_autocmd({ "ExitPre" }, {
    group = "kitty_runner",
    command = "KittyKillRunner",
  })
end

return M
