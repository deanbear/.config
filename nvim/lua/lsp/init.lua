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
  Nnoremap("<Leader>e", vim.diagnostic.open_float, bufopts, "Show Diagnostics")
  Nnoremap("gD", vim.lsp.buf.type_definition, bufopts, "Go to type declaration")
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
  Vnoremap("<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>", bufopts, "Code actions")

  local formatOptions = { async = true, formatting_options = nil }

  -- if vim.bo.filetype == "json" then
  --   formatOptions.formatting_options = { tabSize = 2, insertSpaces = true }
  -- end

  Nnoremap("<space>f", function()
    vim.lsp.buf.format(formatOptions)
  end, bufopts, "Format file")

  Vnoremap("<space>f", function()
    vim.lsp.buf.format(formatOptions)
  end, bufopts, "Format file")

  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end

-- add completion capability
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = Global_on_attach,
})

local HOME = os.getenv("HOME")

lspconfig["volar"].setup({
  filetypes = { "vue" },
  init_options = {
    typescript = {
      tsdk = HOME .. "/node_modules/typescript/lib",
    },
  },
  on_attach = Global_on_attach,
})

lspconfig["rust_analyzer"].setup({
  on_attach = Global_on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})

lspconfig["ts_ls"].setup({
  on_attach = Global_on_attach,
  capabilities = capabilities,
})

lspconfig["pyright"].setup({
  on_attach = Global_on_attach,
  capabilities = capabilities,
})

lspconfig["jsonls"].setup({
  on_attach = Global_on_attach,
  capabilities = capabilities,
})

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

lspconfig["lemminx"].setup({
  on_attach = Global_on_attach,
  capabilities = capabilities,
})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

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
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
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

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- local null_ls = require("null-ls")
-- null_ls.setup({
--   sources = {
--     null_ls.builtins.formatting.stylua.with({
--       extra_args = function(_)
--         local condition = require("null-ls.utils").make_conditional_utils
--         if condition().root_has_file({ "stylua.toml", ".stylua.toml" }) then
--           return {}
--         end
--         return { "--config-path", vim.fn.expand("~/.config/nvim/lua/lsp/stylua.toml") }
--       end,
--     }),
--     null_ls.builtins.formatting.google_java_format.with({
--       method = {
--         null_ls.methods.FORMATTING,
--         null_ls.methods.RANGE_FORMATTING,
--       },
--       extra_args = { "-aosp" },
--     }),
--   },
-- })
