local M = {}

M.options = function ()
  return {
    bigfile = { enabled = true },
    animate = { enabled = true },
    scroll = { enabled = true },
    input = { enabled = true },
    scope = {
      min_size = 2,
      max_size = nil,
      cursor = true,
      edge = true,
      siblings = true,
      filter = function (buf)
        return vim.bo[buf].buftype == "" and vim.b[buf].snacks_scope ~= false and
          vim.g.snacks_scope ~= false
      end,
      debounce = 30,
      treesitter = {
        enabled = true,
        injections = true,
        blocks = {
          enabled = false,
          "function_declaration",
          "function_definition",
          "method_declaration",
          "method_definition",
          "class_declaration",
          "class_definition",
          "do_statement",
          "while_statement",
          "repeat_statement",
          "if_statement",
          "for_statement",
        },
        field_blocks = {
          "local_declaration",
        },
      },
      keys = {
        textobject = {
          ii = {
            min_size = 2,
            edge = false,
            cursor = false,
            treesitter = { blocks = { enabled = false } },
            desc = "inner scope",
          },
          ai = {
            cursor = false,
            min_size = 2,
            treesitter = { blocks = { enabled = false } },
            desc = "full scope",
          },
        },
        jump = {
          ["[i"] = {
            min_size = 2,
            bottom = false,
            cursor = false,
            edge = true,
            treesitter = { blocks = { enabled = false } },
            siblings = true,
            desc = "jump to top edge of scope",
          },
          ["]i"] = {
            bottom = true,
            cursor = false,
            siblings = true,
            treesitter = { blocks = { enabled = false } },
            desc = "jump to bottom edge of scope",
          },
        },
      },
    },
    explorer = { replace_netrw = true },
    dashboard = { enabled = false },
    indent = { enabled = false },
    picker = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    dim = {
      scope = {
        min_size = 10,
        max_size = 30,
        siblings = true,
      },
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        easing = "outQuad",
        duration = {
          step = 20,
          total = 200,
        },
      },
      filter = function (buf)
        return vim.g.snacks_dim ~= false and
          vim.b[buf].snacks_dim ~= false and
          vim.bo[buf].buftype == ""
      end,
    },
  }
end

return M
