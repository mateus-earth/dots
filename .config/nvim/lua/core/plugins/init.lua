local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}
--   use "kyazdani42/nvim-tree.lua"
--   use "akinsho/toggleterm.nvim"
--   use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

--   -- snippets
--   use "L3MON4D3/LuaSnip" --snippet engine
--   use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

--   -- LSP
--   use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
--   use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters


--   use "JoosepAlviste/nvim-ts-context-commentstring"


-- Install your plugins here
packer.startup(
    function(use)
        use "wbthomason/packer.nvim"; -- Have packer manage itself

        -- Core Packages - (other plugins depends on them mostly...)
        use "nvim-lua/popup.nvim";
        use "nvim-lua/plenary.nvim";
        use "kyazdani42/nvim-web-devicons";

        -- Editor
        use "goolord/alpha-nvim";
        use "akinsho/bufferline.nvim";             -- Like the "TabBar" in another editors.
        use 'nvim-lualine/lualine.nvim';           -- Line bellow the editor.
        use "lukas-reineke/indent-blankline.nvim"; -- Make the indentation colorful.
        use "moll/vim-bbye";
        use "folke/which-key.nvim";
        use "nvim-telescope/telescope.nvim";

        -- Themes
        use "tomasiser/vim-code-dark";
        use "lunarvim/colorschemes";

        -- Code Utils
        use "numToStr/Comment.nvim";            -- Toggle comment.
        use "nvim-treesitter/nvim-treesitter";  -- Tree Sitter.
        use "neovim/nvim-lspconfig";            -- Enable LSP.
        use "williamboman/nvim-lsp-installer";  -- Language server installer.
        use {'neoclide/coc.nvim', branch = 'release'}

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end
)

-- @notice: Needs to be the first to be able to cache the plugins.
-- require "plugins.impatient";

require "core.plugins.alpha";
require "core.plugins.comment";
require "core.plugins.bufferline";
require "core.plugins.lualine";
require "core.plugins.indent-blankline";
require "core.plugins.which-key";
require "core.plugins.treesitter";
require "core.plugins.telescope";
require "core.plugins.themes";
