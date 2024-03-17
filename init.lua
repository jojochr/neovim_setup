--[[

===================================================
============== First attempt at lua :) ============
===================================================

--]]

local fn = vim.fn
local execute = vim.api.nvim_command

-- Set <space> as the leader key
-- See ':help mapleader'
--  Note: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ''
vim.g.maplocalleader = ' '

-- Installing plugins with packer
require('plugins')

require('pluginconfigs')

