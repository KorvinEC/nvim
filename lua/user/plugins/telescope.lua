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

        telescope.setup({
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
                            ["<cr>"] = require("telescope-undo.actions").restore,
                            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                            ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
                            -- alternative defaults, for users whose terminals do questionable things with modified <cr>
                            ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
                            ["<C-r>"] = require("telescope-undo.actions").restore,
                        },
                        n = {
                            ["y"] = require("telescope-undo.actions").yank_additions,
                            ["Y"] = require("telescope-undo.actions").yank_deletions,
                            ["u"] = require("telescope-undo.actions").restore,
                        },
                    },
                }
                }
            }
        )

        telescope.load_extension("fzf")
        telescope.load_extension("undo")

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Search files" })
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Search old files" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Search in buffers" })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search help" })
        vim.keymap.set('n', '<leader>fu', telescope.extensions.undo.undo, { desc = "Undo" })
    end,
}
