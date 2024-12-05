return {
    "https://github.com/windwp/nvim-ts-autotag",
    config = function ()
        local ts_autotag = require("nvim-ts-autotag")
        ts_autotag.setup()
    end
}
