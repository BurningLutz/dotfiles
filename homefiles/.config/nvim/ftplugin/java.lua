local config =
{ cmd = { "jdtls" }
, root_dir = vim.fs.root(0, {".git", "pom.xml"})
}

require "jdtls".start_or_attach(config)
