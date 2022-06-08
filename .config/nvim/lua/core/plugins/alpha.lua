local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
    [[                       88                               ]],
    [[ 88d8b.d8b. .d8888b. d8888P .d8888b. dP    dP .d8888b.  ]],
    [[ 88'`88'`88 88'  `88   88   88ooood8 88    88 Y8ooooo.  ]],
    [[ 88  88  88 88.  .88   88   88.  ... 88.  .88       88  ]],
    [[ dP  dP  dP `88888P8   dP   `88888P' `88888P' `88888P'  ]],
    [[                                         88   88        ]],
    [[            .d8888b. .d8888b. 88d888b. d8888P 88d888b.  ]],
    [[            88ooood8 88'  `88 88'  `88   88   88'  `88  ]],
    [[            88.  ... 88.  .88 88         88   88    88  ]],
    [[            `88888P' `88888P8 dP         dP   dP    dP  ]],
}


dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file",           ":Telescope find_files <CR>"),
    dashboard.button("e", "  New file",            ":ene <BAR> startinsert <CR>"),
    dashboard.button("p", "  Find project",        ":Telescope projects <CR>"),
    dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "  Find text",           ":Telescope live_grep <CR>"),
    dashboard.button("c", "  Configuration",       ":e ~/.config/nvim/init.lua <CR>"),
    dashboard.button("q", "  Quit Neovim",         ":qa<CR>"),
}

local function footer()
    return "https://mateus.earth";
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl  = "Type";
dashboard.section.header.opts.hl  = "Include";
dashboard.section.buttons.opts.hl = "Keyword";

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts);
