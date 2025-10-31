local dapmap = {}
local nmaps = {}

local function nmap(lhs, rhs, desc)
  nmaps[lhs] = vim.fn.maparg(lhs, "n", false, true)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end
local function resmap()
  for key, value in pairs(nmaps) do
    if value and not vim.tbl_isempty(value) then
      vim.keymap.set("n", key, value.rhs, value.opt)
    else
      vim.keymap.del("n", key)
    end
  end
  nmaps = {}
end

local nkeymap =
{ continue          = { "dd", "c"}
, pause             = "p"
, toggle_breakpoint = { "db", "a" }
, clear_breakpoints = "cb"
, step_back         = "u"
, step_into         = "i"
, step_out          = "o"
, step_over         = "s"
, terminate         = "x"
}
function dapmap.setup()
  local dap = require "dap"
  vim.bo.modifiable = false

  for key, value in pairs(nkeymap) do
    if value then
      local smap = function (lhs) nmap(lhs, function () dap[key]() end, key) end
      if type(value) == "table" then
        for _, i in ipairs(value) do
          smap(i)
        end
      else
        smap(value)
      end
    end
  end
  return function ()
    vim.bo.modifiable = true
    resmap()
  end
end

return dapmap
