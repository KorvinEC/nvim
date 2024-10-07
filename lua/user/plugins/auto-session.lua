return {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
        enabled = true,
        auto_save = true,
        suppressed_dirs = nil,

        session_lens = {
            load_on_setup = true, -- Initialize on startup (requires Telescope)
            previewer = false, -- File preview for session picker

            mappings = {
                -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
                delete_session = { "i", "<C-D>" },
                alternate_session = { "i", "<C-S>" },
                copy_session = { "i", "<C-Y>" },
            },

            session_control = {
                control_dir = vim.fn.stdpath "data" .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
                control_filename = "session_control.json", -- File name of the session control file
            },
        },
    },
    keys = {
        -- Will use Telescope if installed or a vim.ui.select picker otherwise
        { '<leader>wr', '<cmd>SessionRestore<CR>', desc = 'Session Restore' },
        { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Session save' },
        { '<leader>wf', '<cmd>SessionSearch<CR>', desc = 'Session search' },
        { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
    },
}
