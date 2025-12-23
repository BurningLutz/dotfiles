local M = {}

local function set_keymaps(keymaps, bufnr)
  local dap = require "dap"

  local orig_nmaps = {}
  for name, maps in pairs(keymaps) do
    maps = type(maps) == "table" and maps or { maps }

    for _, lhs in pairs(maps) do
      orig_nmaps[lhs] = vim.fn.maparg(lhs, "n", false, true)
      vim.keymap.set("n", lhs, dap[name], { desc = name, buffer = bufnr })
    end
  end

  return orig_nmaps
end

local function restore_keymaps(orig_nmaps, bufnr)
  for key, value in pairs(orig_nmaps) do
    if value and not vim.tbl_isempty(value) then
      vim.keymap.set("n", key, value.rhs, value.opt)
    else
      vim.keymap.del("n", key, { buffer = bufnr })
    end
  end
end

function M.setup(keymaps, filetype)
  local current_tab  = vim.api.nvim_get_current_tabpage()
  local tracked_bufs = {}

  local function tryset_mode(bufnr)
    if vim.api.nvim_get_current_tabpage() ~= current_tab
    or vim.bo[bufnr].filetype ~= filetype
    or tracked_bufs[bufnr]
    then
      return
    end

    tracked_bufs[bufnr] =
    { modifiable = vim.bo[bufnr].modifiable
    , keymaps    = set_keymaps(keymaps, bufnr)
    }
    vim.bo[bufnr].modifiable = false
  end

  tryset_mode(vim.api.nvim_get_current_buf())

  local auid = vim.api.nvim_create_autocmd(
    "BufEnter"
  , { callback = function (arg)
        tryset_mode(arg.buf)
      end
    }
  )

  return function ()
    vim.api.nvim_del_autocmd(auid)

    for bufnr, oldstate in pairs(tracked_bufs) do
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.bo[bufnr].modifiable = oldstate.modifiable
        restore_keymaps(oldstate.keymaps, bufnr)
      end
    end
  end
end

return M
