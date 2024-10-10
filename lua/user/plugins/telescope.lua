return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
        { "debugloop/telescope-undo.nvim" }
    },
    tag = '0.1.8',
    config = function()
        -- setup telescope
        local telescope = require("telescope")

        local actions = require("telescope.actions")
        local undo_actions = require("telescope-undo.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = actions.cycle_history_next,
                        ["<C-k>"] = actions.cycle_history_prev,
                    },
                    n = {
                        ["<C-j>"] = actions.cycle_history_next,
                        ["<C-k>"] = actions.cycle_history_prev,
                        ["<q>"] = actions.close,
                    },
                },
            },
            extensions = {
                undo = {
                    use_delta = true,
                    use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
                    side_by_side = false,
                    vim_diff_opts = {
                        ctxlen = vim.o.scrolloff,
                    },
                    entry_format = "state #$ID, $STAT, $TIME",
                    time_format = "",
                    saved_only = false,
                    mappings = {
                        i = {
                            ["<cr>"] = undo_actions.restore,
                            ["<S-cr>"] = undo_actions.yank_deletions,
                            ["<C-cr>"] = undo_actions.yank_additions,
                            -- alternative defaults, for users whose terminals do questionable things with modified <cr>
                            ["<C-y>"] = undo_actions.yank_deletions,
                            ["<C-r>"] = undo_actions.restore,
                        },
                        n = {
                            ["y"] = undo_actions.yank_additions,
                            ["Y"] = undo_actions.yank_deletions,
                            ["u"] = undo_actions.restore,
                        },
                    },
                }
                }
            }
        )

        telescope.load_extension("fzf")
        telescope.load_extension("undo")

        local keymap = vim.keymap
        local builtin = require('telescope.builtin')

        keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Search files" })
        keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Search old files" })
        keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
        keymap.set('n', '<leader>fc', function () builtin.live_grep({search_dirs={vim.fn.expand("%:p")}}) end, { desc = "Live grep current file" })
        keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Search in buffers" })
        keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search help" })
        keymap.set('n', '<leader>fu', telescope.extensions.undo.undo, { desc = "Undo" })
        keymap.set("n", "<leader>fd", function () builtin.diagnostics({bufnr=0}) end, { desc = "Show buffer diagnostics" })
    end,
}
