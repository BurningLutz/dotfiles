local M = {}

local origin_nmaps = {}
local function nmap(lhs, rhs, desc)
  origin_nmaps[lhs] = vim.fn.maparg(lhs, "n", false, true)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end
local function resetnmap()
  for key, value in pairs(origin_nmaps) do
    if value and not vim.tbl_isempty(value) then
      vim.keymap.set("n", key, value.rhs, value.opt)
    else
      vim.keymap.del("n", key)
    end
  end
  origin_nmaps = {}
end

local function active()
  vim.bo.modifiable = false
  local dap = require "dap"
  for name, maps in pairs(M.keymap) do
    for _, lhs in ipairs( type(maps) == "table" and maps or { maps } ) do
      nmap(lhs, function () dap[name]() end, name)
    end
  end
end

local function inactive()
  vim.bo.modifiable = true
  resetnmap()
end

function M.setup(keymap)
  if M.winid then
    return
  end

  M.keymap = keymap
  M.winid = vim.api.nvim_get_current_win()
  M.autocmds =
  { vim.api.nvim_create_autocmd(
      "WinEnter"
      , { callback = function ()
            if M.winid and M.winid == vim.api.nvim_get_current_win() then
              active()
            end
          end
        }
    )
  , vim.api.nvim_create_autocmd(
      "WinLeave"
      , { callback = function ()
            if M.winid and M.winid == vim.api.nvim_get_current_win() then
              inactive()
            end
          end
        }
    )
  }
  active()
end

function M.close()
  if M.winid == nil then
    return
  end

  M.winid = nil
  for _, id in ipairs(M.autocmds) do
    vim.api.nvim_del_autocmd(id)
  end
  inactive()
end

return M
