local config =
{ cmd = { "jdtls" }
, root_dir = vim.fs.root(
    0
  , { "build.xml"
    , "pom.xml"
    , "settings.gradle"
    , "settings.gradle.kts"
    , "build.gradle"
    , "build.gradle.kts"
    }
  )
}

require "jdtls".start_or_attach(config)
