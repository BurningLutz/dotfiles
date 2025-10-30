local dapmap = {}
local nmaps = {}
local mapopt = {}

local function nmap(lhs, rhs)
  nmaps[lhs] = vim.fn.maparg(lhs, "n", false, true)
  vim.keymap.set("n", lhs, rhs, mapopt)
end
local function resmap()
  for key, value in pairs(nmaps) do
    if value and not vim.tbl_isempty(value) then
      vim.keymap.set("n", key, value.rhs, mapopt)
    else
      vim.keymap.del("n", key, mapopt)
    end
  end
  nmaps = {}
end

local map =
{ continue   = { key = "<leader>dc", func = function () require "dap".continue() end}
, pause      = { key = "<leader>dp", func = function () require "dap".pause() end}
, run_last   = { key = nil, func = function () require "dap".run_last() end}
, step_back  = { key = "<Up>", func = function () require "dap".step_back() end}
, step_into  = { key = "<Right>", func = function () require "dap".step_into() end}
, step_out   = { key = "<Left>", func = function () require "dap".step_out() end}
, step_over  = { key = "<Down>", func = function () require "dap".step_over() end}
, terminate  = { key = "<leader>dx", func = function () require "dap".terminate() end}
}
function dapmap.setup()
  for _, value in pairs(map) do
    if value and not vim.tbl_isempty(value) then
      if value.key then
        nmap(value.key, value.func)
      end
    end
  end
  return function ()
    resmap()
  end
end

return dapmap
