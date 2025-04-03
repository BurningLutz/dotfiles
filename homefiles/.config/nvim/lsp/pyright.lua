return
{ cmd = { "pyright-langserver", "--stdio" }
, filetypes = { "python" }
, root_markers =
  { "pyproject.toml"
  , "setup.py"
  , "setup.cfg"
  , "requirements.txt"
  , "Pipfile"
  , "pyrightconfig.json"
  , ".git"
  }
, settings =
  { python =
    { pythonPath = ".venv/bin/python"
    , analysis =
      { autoImportCompletions = false
      , autoSearchPaths = true
      , diagnosticMode = "openFilesOnly"
      , typeCheckingMode = "off"
      , useLibraryCodeForTypes = true
      }
    }
  }
}
