local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        prompt_prefix   = "> ",
        selection_caret = "> ",
        path_display    = { "smart" },

        mappings = {
            i = {
                ["<C-/>"] = "which_key",

                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"]   = actions.move_selection_previous,
                
                ["<C-c>"] = actions.close,

                ["<CR>"]  = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"]  = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"]   = actions.move_selection_previous,
            },
        },
    },

    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
   
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    },
}
