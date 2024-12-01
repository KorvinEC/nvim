return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "folke/which-key.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "python",
                "bash",
                "dockerfile",
                "json",
                "javascript",
                "typescript",
                "html",
                "css",
                "tsx",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<A-i>",
                    node_incremental = "<A-i>",
                    scope_incremental = false,
                    node_decremental = "<A-d>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["ad"] = { query = "@assignment.outer", desc = "Select outer assignment" },
                        ["id"] = { query = "@assignment.inner", desc = "Select inner assignment" },

                        ["ld"] = { query = "@assignment.lhs", desc = "Select left side of an assignment" },
                        ["rd"] = { query = "@assignment.rhs", desc = "Select right side of an assignment" },

                        ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter/argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter/argument" },

                        ["af"] = { query = "@function.outer", desc = "Select outer function" },
                        ["if"] = { query = "@function.inner", desc = "Select inner function" },

                        ["ic"] = { query = "@class.inner", desc = "Select inner class" },
                        ["ac"] = { query = "@class.outer", desc = "Select outer class" },

                        ["iv"] = { query = "@call.inner", desc = "Select inner call" },
                        ["av"] = { query = "@call.outer", desc = "Select outer call" },

                        ["ii"] = { query = "@conditional.inner", desc = "Select inner conditional" },
                        ["ai"] = { query = "@conditional.outer", desc = "Select outer conditional" },

                        ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
                        ["al"] = { query = "@loop.outer", desc = "Select outer loop" },

                        ["i/"] = { query = "@comment.inner", desc = "Select inner comment" },
                        ["a/"] = { query = "@comment.outer", desc = "Select outer comment" },

                        ["ib"] = { query = "@block.inner", desc = "Select inner block" },
                        ["ab"] = { query = "@block.outer", desc = "Select outer block" },
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>san"] = { query = "@parameter.inner", desc = "Swap parameters/arguments with next" }, -- swap parameters/argument with next
                        ["<leader>sfn"] = { query = "@function.outer", desc = "Swap function with next" }, -- swap function with next
                    },
                    swap_previous = {
                        ["<leader>sap"] = { query = "@parameter.inner", desc = "Swap parameters/arguments with previous" }, -- swap parameters/argument with prev
                        ["<leader>sfp"] = { query = "@function.outer", desc = "Swap function with previous" }, -- swap function with previous
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
                        ["]c"] = { query = "@call.outer", desc = "Next function call start" },
                        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
                        ["]c"] = { query = "@call.outer", desc = "Next function call end" },
                        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
                        ["[m"] = { query = "@call.outer", desc = "Prev function call start" },
                        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                    },
                    goto_previous_end = {
                        ["[F"] = { query = "@function.outer", desc = "Prev method/function def end" },
                        ["[M"] = { query = "@call.outer", desc = "Prev function call end" },
                        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                    },
                },
            },
        })
        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)


        local which_key = require("which-key")

        which_key.add({
            {"<leader>s", group = " Swap groups"},
            {"<leader>sa", group = " Swap parameters/arguments"},
            {"<leader>sf", group = " Swap functions"},
        })
    end
}
