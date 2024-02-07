# nvim plugin to work with my leetcode-cli/cargo-leet setup
This lets me use neovim to work with [my leetcode-cli/cargo-leet setup](https://github.com/cjon256/dsa). Not really intended for public use, but if you want to use it, go ahead.

Load with Lazy.nvim

```lua
    {
        'cjon256/dsa.nvim',
        config = function()
            require('dsa').setup()
        end,
    },
```
And set up some keybinds like:

```lua
keymap('n', '<leader>lp', ':LeetPy<Space>', { desc = 'pyleet open problem' })
keymap('n', '<leader>lg', ':LeetGo<Space>', { desc = 'goleet open problem' })
keymap('n', '<leader>lr', ':LeetRust<Space>', { desc = 'rsleet open problem' })
keymap('n', '<leader>lt', '<CMD>LeetTest<CR>', { desc = 'leetcode test runner' })
keymap('n', '<leader>lx', '<CMD>LeetSubmit<CR>', { desc = 'leetcode submit runner' })
keymap('n', '<leader>ln', '<CMD>LeetNext<CR>', { desc = 'leetcode next problem' })
keymap('n', '<leader>lo', '<CMD>LeetOpen<CR>', { desc = 'open leetcode page' })
```

This will only be useable with my leetcode setup, but enables working through problems quite quickly with testing set up fairly well and low friction.
