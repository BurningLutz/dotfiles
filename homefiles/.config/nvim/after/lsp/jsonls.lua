return
{ settings =
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
