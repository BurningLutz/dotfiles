local M = {}

local function enable(keymap)
  local dap = require "dap"
  local original_nmaps = {}
  for name, maps in pairs(keymap) do
    for _, lhs in ipairs(type(maps) == "table" and maps or { maps }) do
      original_nmaps[lhs] = vim.fn.maparg(lhs, "n", false, true)
      vim.keymap.set("n", lhs, function () dap[name]() end, { desc = name })
    end
  end

  return original_nmaps
end

local function disable(original_nmaps)
  for key, value in pairs(original_nmaps) do
    if value and not vim.tbl_isempty(value) then
      vim.keymap.set("n", key, value.rhs, value.opt)
    else
      vim.keymap.del("n", key)
    end
  end
end

function M.setup(keymap, filetype)
  local tracked_bufs = {}

  local function set_readonly(bufnr)
    if filetype and vim.bo[bufnr].filetype ~= filetype then
      return
    end

    if not tracked_bufs[bufnr] then
      tracked_bufs[bufnr] = vim.bo[bufnr].modifiable
    end
    vim.bo[bufnr].modifiable = false
  end

  set_readonly(vim.api.nvim_get_current_buf())
  local original_nmaps = enable(keymap)

  local autocmds       =
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
    for bufnr, original_modifiable in pairs(tracked_bufs) do
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.bo[bufnr].modifiable = original_modifiable
      end
    end
    disable(original_nmaps)
    original_nmaps = {}
    tracked_bufs   = {}
  end
end

return M
