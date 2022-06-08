-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end


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

vim.cmd [[
    augroup lua_auto_reload
    autocmd!
    autocmd BufWritePost *.lua source <afile>
    augroup end
]]


-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}
--   -- LSP
--   use { "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
--   use { "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
--   use { "JoosepAlviste/nvim-ts-context-commentstring"

packer.startup(function(use)
    use { "wbthomason/packer.nvim" }; -- Have packer manage itself

    -- Core Packages
    --   (other plugins depends on them mostly...)
    use {
        "nvim-lua/popup.nvim",          
        "nvim-lua/plenary.nvim",        
        "kyazdani42/nvim-web-devicons",
    };

    -- Editor
    --   (features that change the program experience as whole)
    use { "goolord/alpha-nvim"                  }; -- Main Page.
    use { "akinsho/bufferline.nvim"             }; -- Like the "TabBar" in another editors.
    use { "nvim-lualine/lualine.nvim"           }; -- Line bellow the editor.
    use { "moll/vim-bbye"                       }; -- Delete buffers (close files) without closing your windows
    use { "mcauley-penney/tidy.nvim"            }; -- Clean trailing spaces and newlines.
    use { "folke/which-key.nvim"                };
    use { "nvim-telescope/telescope.nvim"       };
    use { "kyazdani42/nvim-tree.lua"            }; -- Solution Explorer
    use { "akinsho/toggleterm.nvim",
          tag = 'v1.*'                          }; -- Terminal

    -- Themes
    use { "tomasiser/vim-code-dark" };

    -- Code Utils
    --   (plugins that improve editing/programming experience).
    use { 
        "numToStr/Comment.nvim",    -- Toggle comment.
        "junegunn/vim-easy-align",  -- Code Align.
        "folke/trouble.nvim",       -- A pretty list for showing diagnostics.
        "p00f/nvim-ts-rainbow",     -- Colorize the brackets...
    }; 

    -- Tree Sitter.
    use { 
        'nvim-treesitter/nvim-treesitter', 
        run    = ':TSUpdate' 
    }; 

    -- LSP
    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    };
    
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)


require "core.plugins.lsp";
require "core.plugins.comment";
require "core.plugins.nvim-tree";

require "core.plugins.treesitter";

require "core.plugins.alpha";
require "core.plugins.bufferline";
require "core.plugins.lualine";
require "core.plugins.toggleterm";
require "core.plugins.trouble"
require "core.plugins.telescope";
require "core.plugins.themes";

require "core.plugins.which-key";
