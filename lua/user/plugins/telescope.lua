return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" }
    },
    tag = '0.1.8',
    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Search files" })
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Search old files" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Search in buffers" })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search help" })

        local telescope = require("telescope")

        telescope.load_extension("fzf")
    end
}
