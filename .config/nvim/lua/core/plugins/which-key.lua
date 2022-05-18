local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks     = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        
        spelling = {
            enabled     = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20,   -- how many suggestions should be shown in the list?
        },

        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators    = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions      = true,  -- adds help for motions
            text_objects = true,  -- help for text objects triggered after entering an operator
            windows      = true,  -- default bindings on <c-w>
            nav          = true,  -- misc bindings to work with windows
            z            = true,  -- bindings for folds, spelling and others prefixed with z
            g            = true,  -- bindings for prefixed with g
        },
    },

    key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"]    = "RET",
        ["<tab>"]   = "TAB",
    },

    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator  = "➜", -- symbol used between a key and it's label
        group      = "+", -- symbol prepended to a group
    },

    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up   = "<c-u>", -- binding to scroll up inside the popup
    },

    window = {
        border   = "double", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        
        margin  = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]

        winblend = 0,
    },

    layout = {
        height  = { min = 4,  max = 25 }, -- min and max height of the columns
        width   = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 5,                      -- spacing between columns
        align   = "center",               -- align columns left, center or right
    },

    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden         = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate show_help = true, -- show help message on the command line when the popup is visible
    triggers       = "auto", -- automatically setup triggers
}

local opts = {
    mode    = "n", -- NORMAL mode
    prefix  = "<leader>",
    buffer  = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
    silent  = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait  = true, -- use `nowait` when creating keymaps
}

local mappings = {
    ["e"] = { 
        name = "Editor",
        r = { "<cmd>luafile %<CR>", "reload lua" },
        s = { "<cmd>w!<CR>", "save"  },
        c = { "<cmd>Bdelete!<CR>", "close" },
    },
    
    ["f"] = {
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Find files",
    },

    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>",    "Sync" },
        S = { "<cmd>PackerStatus<cr>",  "Status" },
        u = { "<cmd>PackerUpdate<cr>",  "Update" },
    },
    
    s = {
        name = "Search",

        t = { "<cmd>Telescope colorscheme<cr>",  "themes"    },
        h = { "<cmd>Telescope help_tags<cr>",    "vim-help"  },
        m = { "<cmd>Telescope man_pages<cr>",    "man-pages" },
        k = { "<cmd>Telescope keymaps<cr>",      "keymaps"   },
        C = { "<cmd>Telescope commands<cr>",     "commands"  },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
