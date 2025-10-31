local M = {}

local winid = nil
local original_nmaps = {}
local function nmap(lhs, rhs, desc)
  original_nmaps[lhs] = vim.fn.maparg(lhs, "n", false, true)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end
local function resetnmap()
  for key, value in pairs(original_nmaps) do
    if value and not vim.tbl_isempty(value) then
      vim.keymap.set("n", key, value.rhs, value.opt)
    else
      vim.keymap.del("n", key)
    end
  end
  original_nmaps = {}
end

local function enable()
  vim.bo.modifiable = false
  local dap = require "dap"
  for name, maps in pairs(M.keymap) do
    for _, lhs in ipairs( type(maps) == "table" and maps or { maps } ) do
      nmap(lhs, function () dap[name]() end, name)
    end
  end
end

local function disable()
  vim.bo.modifiable = true
  resetnmap()
end

function M.setup(keymap)
  if winid then
    return
  end

  M.keymap = keymap
  winid = vim.api.nvim_get_current_win()
  M.autocmds =
  { vim.api.nvim_create_autocmd(
      "WinEnter"
      , { callback = function ()
            if winid and winid == vim.api.nvim_get_current_win() then
              enable()
            end
          end
        }
    )
  , vim.api.nvim_create_autocmd(
      "WinLeave"
      , { callback = function ()
            if winid and winid == vim.api.nvim_get_current_win() then
              disable()
            end
          end
        }
    )
  }
  enable()
end

function M.close()
  if winid == nil then
    return
  end

  winid = nil
  for _, id in ipairs(M.autocmds) do
    vim.api.nvim_del_autocmd(id)
  end
  M.autocmds = nil
  disable()
end

return M
