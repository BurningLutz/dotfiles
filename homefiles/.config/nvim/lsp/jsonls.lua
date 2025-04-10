return
{ cmd = { "vscode-json-language-server", "--stdio" }
, filetypes = { "json", "jsonc" }
, init_options =
  { provideFormatter = true
  }
, root_markers = { ".git" }
, settings =
  { json =
    { schemas =
      { { fileMatch = { "package.json" }
        , url = "https://json.schemastore.org/package.json"
        }
      , { fileMatch = { "tsconfig.json" }
        , url = "https://json.schemastore.org/tsconfig.json"
        }
      , { fileMatch = { "jsconfig.json" }
        , url = "https://json.schemastore.org/jsconfig.json"
        }
      }
    }
  }
}
