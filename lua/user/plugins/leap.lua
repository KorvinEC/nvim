return {
    "https://github.com/ggandor/leap.nvim",
    dependencies = {
        "https://github.com/tpope/vim-repeat",
    },
    config = function ()
        local leap = require('leap')
        leap.opts.safe_labels = {}

        -- The below settings make Leap's highlighting closer to what you've been
        -- used to in Lightspeed.

        vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
        vim.api.nvim_set_hl(0, 'LeapMatch', {
          -- For light themes, set to 'black' or similar.
          fg = 'white', bold = true, nocombine = true,
        })
        -- Deprecated option. Try it without this setting first, you might find
        -- you don't even miss it.
        leap.opts.highlight_unlabeled_phase_one_targets = true

        vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
        vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
        vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
    end,
}
