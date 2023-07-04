local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify "JDTLS not found."
  return
end

local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/mason/packages/jdtls"
local HOME = os.getenv "HOME"
local WORKSPACE_PATH = HOME .. "/Work/workspace/eclipse/"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local root_markers = {'gradlew', 'mvnw', '.git', "pom.xml"}
local root_dir = require('jdtls.setup').find_root(root_markers)


local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

local on_attach = function(client, bufnr)
	-- Regular Neovim LSP client keymappings
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
	nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
	nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
	nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
	nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
	nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
	nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
	nnoremap('<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts, "List workspace folders")
	nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
	nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
	nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
	vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
		{ noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })
	nnoremap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")

	-- Java extensions provided by jdtls
	nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
	nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
	nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
	vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
		{ noremap=true, silent=true, buffer=bufnr, desc = "Extract method" })
end

local config = {
	on_attach = on_attach,
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. JDTLS_LOCATION .. "/lombok.jar",
		"-jar",
		vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		JDTLS_LOCATION .. "/config_mac",
		"-data",
		workspace_dir,
	},

  capabilities = vim.lsp.protocol.make_client_capabilities(),
	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				runtimes = {
          {
            name = "JavaSE-18",
            path = HOME .. "/Library/Java/JavaVirtualMachines/openjdk-18.0.1.1/Contents/Home/",
          },
          {
            name = "JavaSE-11",
						path = "/opt/homebrew/Cellar/openjdk@11/11.0.19/libexec/openjdk.jdk/Contents/Home/",
          },
					{
						name = "JavaSE-1.8",
						path = "/Library/Java/JavaVirtualMachines/jdk1.8.0_291.jdk/Contents/Home/",
					},
        },
				updateBuildConfiguration = "interactive",
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			format = {
				enabled = false,
			},
		},
		signatureHelp = { enabled = true },
		completion = {
			favoriteStaticMembers = {
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
		},
		extendedClientCapabilities = extendedClientCapabilities,
	},

	flags = {
		allow_incremental_sync = true,
	},
	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

-- Add the commands
require("jdtls.setup").add_commands()
-- vim.api.nvim_exec(
--   [[
-- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
-- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
-- command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
-- command! -buffer JdtJol lua require('jdtls').jol()
-- command! -buffer JdtBytecode lua require('jdtls').javap()
-- command! -buffer JdtJshell lua require('jdtls').jshell(),
--   ]],
--   false
-- )

vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
