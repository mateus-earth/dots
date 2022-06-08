local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup{
    open_mapping = [[<c-\>]],

    hide_numbers      = true, -- hide the number column in toggleterm buffers
    shade_filetypes   = {},
    shade_terminals   = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    shading_factor    = 1,    -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert   = true,
    insert_mappings   = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size      = true,

    direction     = 'float',
    close_on_exit = false,        -- close the terminal window when the process exits
    shell         = vim.o.shell,  -- change the default shell

    float_opts = {
        border   = _G._my_opt.border,
        winblend = _G._my_opt.winblend,
        width    = 100,
        height   = 25,
    }
}


--
-- guitui
--
--------------------------------------------------------------------------------
local Terminal = require('toggleterm.terminal').Terminal;
local gitui = Terminal:new ({
    cmd           = "gitui",
    direction     = "float",
    close_on_exit = false,   -- close the terminal window when the process exits
    clear_env     = false,   -- use only environmental variables from `env`, passed to jobstart()
    -- dir = string -- the directory for the terminal
    -- env = table -- key:value table with environmental variables passed to jobstart()
});


--------------------------------------------------------------------------------
_G.hack_terminal_gitui = gitui; -- @XXX: Is ok to append to the global obj???
