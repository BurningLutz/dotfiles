local config =
{ cmd = { "jdtls" }
, root_dir = vim.fs.root(0, {".git", "pom.xml"})
, capabilities = vim.tbl_deep_extend(
    "force"
  , vim.lsp.protocol.make_client_capabilities()
  , require"cmp_nvim_lsp".default_capabilities()
  )
}

require "jdtls".start_or_attach(config)
