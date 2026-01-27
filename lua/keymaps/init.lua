return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      -- LSP
      { "<Leader>ln", vim.lsp.buf.rename, desc = "Rename" },
      { "<Leader>la", vim.lsp.buf.code_action, mode = { "n", "x" }, desc = "Code Action" },
      { "<Leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "Definition" },
      { "<Leader>lD", function() Snacks.picker.lsp_declarations() end, desc = "Declaration" },
      { "<Leader>lr", function() Snacks.picker.lsp_references() end, desc = "References" },
      { "<Leader>lI", function() Snacks.picker.lsp_implementations() end, desc = "Implementation" },
      { "<Leader>ly", function() Snacks.picker.lsp_type_definitions() end, desc = "Type Definition" },
      { "<Leader>li", function() Snacks.picker.lsp_incoming_calls() end, desc = "Calls Incoming" },
      { "<Leader>lo", function() Snacks.picker.lsp_outgoing_calls() end, desc = "Calls Outgoing" },
      { "<Leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Symbols" },
      { "<Leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
    },
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    keys = {
      -- Top Pickers & Explorer
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>bb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>br", function() Snacks.picker.recent() end, desc = "Recent" },
      -- Grep
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      {
        "<leader>sw",
        function() Snacks.picker.grep_word() end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      -- Other
      { "<leader>c", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>lR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<leader>gy", function() Snacks.gitbrowse.get_url() end, desc = "Git URL", mode = { "n", "v" } },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
  },
  {
    "nvim-mini/mini.clue",
    version = false,
    opts = function(_, opts)
      local miniclue = require "mini.clue"
      opts.window = {
        delay = 200,
        config = {
          width = 50,
        },
      }
      opts.triggers = {
        -- Leader triggers
        { mode = { "n", "x" }, keys = "<Leader>" },

        -- `[` and `]` keys
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = { "n", "x" }, keys = "g" },

        -- Marks
        { mode = { "n", "x" }, keys = "'" },
        { mode = { "n", "x" }, keys = "`" },

        -- Registers
        { mode = { "n", "x" }, keys = '"' },
        { mode = { "i", "c" }, keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = { "n", "x" }, keys = "z" },
      }

      opts.clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),

        -- Search with Snacks.picker
        { mode = "n", keys = "<Leader>s", desc = "Search" },

        -- Git
        { mode = "n", keys = "<Leader>g", desc = "Git" },

        -- LSP
        { mode = "n", keys = "<Leader>l", desc = "LSP" },
      }
    end,
  },
}
