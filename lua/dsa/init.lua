-- luacheck: globals vim
return {
    most_recent_id = 0,
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
                    vim.print("No information found")
                else
                    require("dsa").most_recent_id = id.args
                    local dir = string.match(info, "dir: ([^\n]+)\n")
                    local file = string.match(info, "file: (.+)\n")
                    vim.fn.chdir(dir)
                    vim.cmd("e " .. file)
                end
            end,
            { nargs = 1 }
        )

        vim.api.nvim_create_user_command(
            'LeetPyPrompt',
            function()
                local id = vim.fn.input("Enter the problem id: ")
                local handler = io.popen("pyleet info " .. id.args)
                if handler == nil then
                    print("handler is nil")
                    return
                end
                local info = handler:read("*a")
                if info == "" then
                    vim.print("No information found")
                else
                    require("dsa").most_recent_id = id.args
                    local dir = string.match(info, "dir: ([^\n]+)\n")
                    local file = string.match(info, "file: (.+)\n")
                    vim.fn.chdir(dir)
                    vim.cmd("e " .. file)
                end
            end,
            { nargs = 0 }
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
                    vim.print("No information found")
                else
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
                    print("No information found")
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
            'LeetTest',
            function()
                local most_recent_id = require("dsa").most_recent_id
                if vim.bo.filetype == "python" then
                    local handler = io.popen("pyleet test " .. most_recent_id)
                    if handler == nil then
                        print("handler is nil")
                        return
                    end
                    local info = handler:read("*a")
                    if info == "" then
                        print("No information found")
                    else
                        vim.print(info)
                    end
                elseif vim.bo.filetype == "go" then
                    local handler = io.popen("goleet test " .. most_recent_id)
                    if handler == nil then
                        print("handler is nil")
                        return
                    end
                    local info = handler:read("*a")
                    if info == "" then
                        print("No information found")
                    else
                        vim.print(vim.inspect(info))
                    end
                elseif vim.bo.filetype == "rust" then
                    local handler = io.popen("rsleet test " .. most_recent_id)
                    if handler == nil then
                        print("handler is nil")
                        return
                    end
                    local info = handler:read("*a")
                    if info == "" then
                        print("No information found")
                    else
                        vim.print(vim.inspect(info))
                    end
                else
                    print("Unsupported filetype")
                end
            end,
            { nargs = 0 }
        )
    end,
}
