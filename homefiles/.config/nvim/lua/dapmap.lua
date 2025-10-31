local M = {}

local function resetnmap(original_nmaps)
  for key, value in pairs(original_nmaps) do
    if value and not vim.tbl_isempty(value) then
      vim.keymap.set("n", key, value.rhs, value.opt)
    else
      vim.keymap.del("n", key)
    end
  end
end

local function enable(keymap)
  vim.bo.modifiable = false
  local dap = require "dap"
  local original_nmaps = {}
  for name, maps in pairs(keymap) do
    for _, lhs in ipairs( type(maps) == "table" and maps or { maps } ) do
      original_nmaps[lhs] = vim.fn.maparg(lhs, "n", false, true)
      vim.keymap.set("n", lhs, function () dap[name]() end, { desc = name })
    end
  end

  return original_nmaps
end

local function disable(original_nmaps)
  vim.bo.modifiable = true
  resetnmap(original_nmaps)
end

function M.setup(keymap)
  local winid          = vim.api.nvim_get_current_win()
  local original_nmaps = enable(keymap)
  local autocmds       =
  { vim.api.nvim_create_autocmd(
      "WinEnter"
      , { callback = function ()
            if winid == vim.api.nvim_get_current_win() then
              original_nmaps = enable(keymap)
            end
          end
        }
    )
  , vim.api.nvim_create_autocmd(
      "WinLeave"
      , { callback = function ()
            if winid == vim.api.nvim_get_current_win() then
              disable(original_nmaps)
            end
          end
        }
    )
  }

  return function ()
    for _, id in ipairs(autocmds) do
      vim.api.nvim_del_autocmd(id)
    end
    disable(original_nmaps)
  end
end

return M
