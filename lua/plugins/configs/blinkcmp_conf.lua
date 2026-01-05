return {
  require("blink-cmp").setup({
    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                -- bug fix js // 
                if ctx.source_name == "Path" and ctx.item and ctx.item.data then
                  local status, mini_icon = pcall(function()
                    return require("mini.icons").get_icon(ctx.item.data.type or "", ctx.label or "")
                  end)
                  
                  if status and mini_icon then
                    return mini_icon .. ctx.icon_gap
                  end
                end

                -- 2. Pengecekan aman untuk lspkind
                local status_lsp, icon = pcall(function()
                  return require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                end)
                
                return (status_lsp and icon or ctx.kind or "") .. ctx.icon_gap
              end,

              highlight = function(ctx)
                if ctx.source_name == "Path" and ctx.item and ctx.item.data then
                  local status, _, mini_hl = pcall(function()
                    return require("mini.icons").get_icon(ctx.item.data.type or "", ctx.label or "")
                  end)
                  
                  if status and mini_hl then return mini_hl end
                end
                return ctx.kind_hl
              end,
            },
            kind = {
              highlight = function(ctx)
                if ctx.source_name == "Path" and ctx.item and ctx.item.data then
                  local status, _, mini_hl = pcall(function()
                    return require("mini.icons").get_icon(ctx.item.data.type or "", ctx.label or "")
                  end)
                  
                  if status and mini_hl then return mini_hl end
                end
                return ctx.kind_hl
              end,
            },
          },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },
    signature = { enabled = true },
    keymap = {
      preset = "none",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<C-l>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "accept", "fallback" },
    },
    cmdline = {
      keymap = {
        ["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
        ["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },
        ["<CR>"] = { "select_accept_and_enter", "fallback" },
      },
    },
  }),
}