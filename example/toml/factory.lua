local M = {}

M.lazy = {
  ["monaqa/dial.nvim"] = {
    keys = { mode = "n", { "<C-a>", "<C-x>", "<C-a>", "<C-x>" } },
  },
  ["max397574/better-escape.nvim"] = {
    opts = {
      mapping = { "jk", "jj" },
      timeout = vim.o.timeoutlen,
      clear_empty_lines = false,
      keys = "<Esc>",
    },
  },
  ["tversteeg/registers.nvim"] = {
    keys = {
      { '"', mode = { "n", "v" } },
      { "<C-R>", mode = "i" },
    },
  },
  ["aurum77/live-server.nvim"] = {
    build = function() require("live_server.util").install() end,
    opts = {
      port = 8080,
      browser_command = "firefox",
      quiet = true,
      no_css_inject = true,
      install_path = vim.fn.stdpath("state") .. "/live",
    },
  },
  ["TimUntersberger/neogit"] = {
    opts = {
      signs = {
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
    },
  },
  ["numToStr/Comment.nvim"] = {
    keys = {
      "g",
      { mode = "v", "g" },
      { mode = "i", "g" },
      { mode = "x", "g" }
    },
  },
  ["RRethy/nvim-treesitter-textsubjects"] = {
    keys = {
      { mode = "v", "." },
      { mode = "v", ";" }
    },
  },
  ["mbbill/undotree"] = {
    init = function()
      vim.g.undotree_WindowLayout = 4
      vim.g.undotree_ShortIndicators = 0
      vim.g.undotree_DiffpanelHeight = 10
      vim.g.undotree_DiffAutoOpen = 1
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_SplitWidth = 40
      vim.g.undotree_TreeNodeShape = "*"
      vim.g.undotree_TreeVertShape = "|"
      vim.g.undotree_TreeSplitShape = "/"
      vim.g.undotree_TreeReturnShape = "\\"
      vim.g.undotree_DiffCommand = "diff"
      vim.g.undotree_RelativeTimestamp = 1
      vim.g.undotree_HighlightChangedText = 1
      vim.g.undotree_HighlightChangedWithSign = 1
      vim.g.undotree_HighlightSyntaxAdd = "DiffAdd"
      vim.g.undotree_HighlightSyntaxChange = "DiffChange"
      vim.g.undotree_HighlightSyntaxDel = "DiffDelete"
      vim.g.undotree_HelpLine = 1
      vim.g.undotree_CursorLine = 1
    end,
  },
  ["toppair/peek.nvim"] = {
    opts = {
      auto_load = true,
      close_on_bdelete = true,
      syntax = true,
      theme = "dark",
      update_on_change = true,
      app = vim.env.BROWSER,
      filetype = { "markdown" },
      throttle_at = 200000,
      throttle_time = "auto",
    },
  },
  ["WhoIsSethDaniel/mason-tool-installer.nvim"] = {
    opts = {
      ensure_installed = { "bash-language-server", "shellcheck", "shfmt", "vint" },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
    },
  },
  ["jayp0521/mason-null-ls.nvim"] = {
    opts = {
      automatic_installation = true,
      automatic_setup = true,
      ensure_installed = {
        "autopep8",
        "eslint_d",
        "fixjson",
        "isort",
        "stylua",
        "markdownlint",
        "sqlfluff",
        "stylelint",
        "shellcheck",
        "vint",
        "prettier",
        "black",
        "shellharden",
        "gitlint",
        "shfmt",
      },
    },
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "bashls",
        "cmake",
        "jdtls",
        "texlab",
        "jsonls",
        "yamlls",
        "pyright",
        "lua_ls",
        "cssls",
        "stylelint_lsp",
        "emmet_ls",
        "tailwindcss",
        "grammarly",
        "html",
        "awk_ls",
        "vimls",
        "clangd",
        "rust_analyzer",
        "sourcery",
      },
    },
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    opts = {
      ensure_installed = { "bash-language-server", "shellcheck", "shfmt", "vint" },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
    },
  },
  ["hrsh7th/nvim-cmp"] = {
    keys = { mode = "i", "<C-Space>" },
  },
  ["doums/monark.nvim"] = {
    opts = {
      clear_on_normal = true,
      sticky = true,
      offset = 2,
      timeout = 300,
      i_idle_to = 1000,
      modes = {
        normal = { " ", "MonarkNormal" },
        visual = { " ", "MonarkVisual" },
        visual_l = { " ", "MonarkVisualLine" },
        visual_b = { " ", "MonarkVisualBlock" },
        select = { " ", "MonarkSelect" },
        insert = { " ", "MonarkInsert" },
        replace = { " ", "MonarkReplace" },
        terminal = { " ", "MonarkTerminal" },
      },
      hl_mode = "combine",
      ignore = { "c" },
    },
  },
}

return M
