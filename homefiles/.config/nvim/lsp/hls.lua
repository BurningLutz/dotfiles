return
{ cmd = { "haskell-language-server-wrapper", "--lsp" }
, filetypes = { "haskell", "lhaskell", "cabal" }
, root_markers =
  { "hie.yaml"
  , "stack.yaml"
  , "cabal.project"
  , "*.cabal"
  , "package.yaml"
  }
, settings =
  { haskell =
    { plugin =
      { ["ghcide-completions"] =
        { config =
          { snippetsOn = false
          , autoExtendOn = false
          }
        }
      , semanticTokens = { globalOn = true }
      }
    , maxCompletions = 100
    , sessionLoading = "multipleComponents"
    , formattingProvider = "stylish-haskell"
    , cabalFormattingProvider = "cabalfmt"
    }
  }
}
