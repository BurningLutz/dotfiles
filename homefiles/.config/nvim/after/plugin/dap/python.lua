local dap = require "dap"

dap.adapters.python = function (cb, config)
  if config.request == "attach" then
    ---@diagnostic disable-next-line: undefined-field
    local port = assert((config.connect or config).port, "`connect.port` is required for a python `attach` configuration")
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or "127.0.0.1"
    cb
    { type = "server"
    , port = port
    , host = host
    , options = { source_filetype = "python" }
    }
  else
    cb
    { type = "executable"
    , command = "debugpy-adapter"
    , options = { source_filetype = "python" }
    }
  end
end

dap.configurations.python =
{ { type = "python"
  , name = "Launch file"
  , request = "launch"

  , console = "integratedTerminal"
  , program = "${file}"
  , pythonPath = function ()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "python3"
      end
    end
  }
}
