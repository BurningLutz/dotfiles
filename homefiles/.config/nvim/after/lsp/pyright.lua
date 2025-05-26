return
{ settings =
  { python =
    { pythonPath = ".venv/bin/python"
    , disableOrganizeImports = false
    , analysis =
      { autoImportCompletions = true
      , autoSearchPaths = true
      , diagnosticMode = "openFilesOnly"
      , typeCheckingMode = "off"
      , useLibraryCodeForTypes = true
      }
    }
  }
}
