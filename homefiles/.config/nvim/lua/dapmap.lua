local M = {}

local function enable(keymap, bufnr)
  local dap = require "dap"
  local original_nmaps = {}
  for name, maps in pairs(keymap) do
    for _, lhs in ipairs(type(maps) == "table" and maps or { maps }) do
      original_nmaps[lhs] = vim.fn.maparg(lhs, "n", false, true)
      vim.keymap.set("n", lhs, function() dap[name]() end, { desc = name, buffer = bufnr })
    end
  end

  return original_nmaps
end

local function disable(original_nmaps, bufnr)
  for key, value in pairs(original_nmaps) do
    if value and not vim.tbl_isempty(value) then
      vim.keymap.set("n", key, value.rhs, value.opt)
    else
      vim.keymap.del("n", key, { buffer = bufnr })
    end
  end
end

local function buf_in_tab(bufnr, tabpage)
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      return true
    end
  end
  return false
end

function M.setup(keymap, filetype)
  local target_tab     = vim.api.nvim_get_current_tabpage()
  local tracked_bufs   = {}

  local function set_readonly(bufnr)
    if filetype and vim.bo[bufnr].filetype ~= filetype then
      return
    end
    if not buf_in_tab(bufnr, target_tab) then
      return
    end

    if not tracked_bufs[bufnr] then
      tracked_bufs[bufnr] =
      { modifiable = vim.bo[bufnr].modifiable
      , keymaps    = enable(keymap, bufnr)
      }
    end
    vim.bo[bufnr].modifiable = false
  end

  set_readonly(vim.api.nvim_get_current_buf())
  local autocmds =
  { vim.api.nvim_create_autocmd(
      "BufEnter"
    , { callback = function ()
          set_readonly(vim.api.nvim_get_current_buf())
        end
      }
    )
  }

  return function ()
    for _, id in ipairs(autocmds) do
      vim.api.nvim_del_autocmd(id)
    end
    for bufnr, state in pairs(tracked_bufs) do
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.bo[bufnr].modifiable = state.modifiable
        disable(state.keymaps, bufnr)
      end
    end
    tracked_bufs = {}
  end
end

return M
