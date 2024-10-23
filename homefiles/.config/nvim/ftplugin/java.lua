local config =
{ cmd = { "jdtls" }
, root_dir = vim.fs.root(
    0
  , { "build.xml"
    , "pom.xml"
    }
  )
}

require "jdtls".start_or_attach(config)
