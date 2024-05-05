-- This file is written to work with the packer plugin to manage my plugins
 
-- ========================================================================
-- ================== Check if packer is installed ========================
-- ========================================================================
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-- ========================================================================
-- ===================== Install plugins via Packer =======================
-- ========================================================================
return require("packer").startup(function(use)
	
	-- Packer managing itsself :)
	use "wbthomason/packer.nvim"

	-- Attempt of importing lualine
	use {"nvim-lualine/lualine.nvim",
		requires = { 'nvim-tree/nvim-web-devicons', opt = true}
	}

	-- Command suggestions
	use {
		"folke/which-key.nvim",
		event = 'VimEnter', -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
		
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		require("which-key").setup {
			-- leave it empty to use the default settings
		}

		-- Document existing key chains
		require('which-key').register {
			  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
			  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
			  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
			  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
			  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' }
			}
		end
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	-- Only gets run if packer was not installed when the scripts started
	if packer_bootstrap then
    		require("packer").sync()
	end
end)


