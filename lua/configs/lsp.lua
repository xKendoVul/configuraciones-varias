require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "ts_ls", "lua_ls" },
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs({ "pyright", "ts_ls", "lua_ls" }) do
	lspconfig[server].setup({
		capabilities = capabilities,
	})
end
