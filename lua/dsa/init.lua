return {
    setup = function()
        vim.api.nvim_create_user_command(
            'LeetPy',
            function(id)
                local handler = io.popen("pyleet info " .. id.args)
                if handler == nil then
                    print("handler is nil")
                    return
                end
                local info = handler:read("*a")
                if info == "" then
                    info = "No information found"
                else
                    vim.print(vim.inspect(info))
                    local dir = string.match(info, "dir: ([^\n]+)\n")
                    local file = string.match(info, "file: (.+)\n")
                    vim.fn.chdir(dir)
                    vim.cmd("e " .. file)
                end
            end,
            { nargs = 1 }
        )

        vim.api.nvim_create_user_command(
            'LeetGo',
            function(id)
                local handler = io.popen("goleet info " .. id.args)
                if handler == nil then
                    print("handler is nil")
                    return
                end
                local info = handler:read("*a")
                if info == "" then
                    info = "No information found"
                else
                    vim.print(vim.inspect(info))
                    local dir = string.match(info, "dir: ([^\n]+)\n")
                    local file = string.match(info, "file: (.+)\n")
                    vim.fn.chdir(dir)
                    vim.cmd("e " .. file)
                end
            end,
            { nargs = 1 }
        )

        vim.api.nvim_create_user_command(
            'LeetRust',
            function(id)
                local handler = io.popen("rsleet info " .. id.args)
                if handler == nil then
                    print("handler is nil")
                    return
                end
                local info = handler:read("*a")
                if info == "" then
                    info = "No information found"
                else
                    vim.print(vim.inspect(info))
                    local dir = string.match(info, "dir: ([^\n]+)\n")
                    local file = string.match(info, "file: (.+)\n")
                    vim.fn.chdir(dir)
                    vim.cmd("e " .. file)
                end
            end,
            { nargs = 1 }
        )
    end,
}
