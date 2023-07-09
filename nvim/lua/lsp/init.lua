function Nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

function Vnoremap(rhs, lhs, bufopts, desc)
	bufopts.desc = desc
	vim.keymap.set("v", rhs, lhs, bufopts)
end

function Global_on_attach(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  Nnoremap("gD", vim.lsp.buf.declaration, bufopts, "Go to declaration")
  Nnoremap("gd", vim.lsp.buf.definition, bufopts, "Go to definition")
  Nnoremap("gi", vim.lsp.buf.implementation, bufopts, "Go to implementation")
  Nnoremap("K", vim.lsp.buf.hover, bufopts, "Hover text")
  Nnoremap("<C-k>", vim.lsp.buf.signature_help, bufopts, "Show signature")
  Nnoremap("<space>wa", vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
  Nnoremap("<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
  Nnoremap("<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts, "List workspace folders")
  Nnoremap("<space>D", vim.lsp.buf.type_definition, bufopts, "Go to type definition")
  Nnoremap("<space>rn", vim.lsp.buf.rename, bufopts, "Rename")
  Nnoremap("<space>ca", vim.lsp.buf.code_action, bufopts, "Code actions")
  vim.keymap.set(
    "v",
    "<space>ca",
    "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "Code actions" }
  )
  Nnoremap("<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts, "Format file")
  Vnoremap("<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts, "Format file")
end
-- add completion capability
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

lspconfig["lua_ls"].setup({
  on_attach = Global_on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "vsnip" },
  },
  snippet = {
    expand = function(args)
      -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<M-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text", -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    }),
  },
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/lua/lsp/stylua.toml") },
    }),
  },
})
