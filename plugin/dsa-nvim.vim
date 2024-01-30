" Title:        dsa-nvim
" Description:  A plugin to use by leetcode scripts from neovim
" Last Change:  2024-01-30
" Maintainer:   Cullen ONeill <>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_cjon256_dsa_nvim")
    finish
endif
let g:loaded_cjon256_dsa_nvim = 1

" Defines a package path for Lua. This facilitates importing the
" Lua modules from the plugin's dependency directory.
" let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/example-plugin/deps"
" exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=1 Pyleet lua require("dsa.nvim").pyleet(<f-args>)
