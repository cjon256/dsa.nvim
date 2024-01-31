-- luacheck: globals vim
return {
    most_recent_id = 0,
    setup = function()
        vim.api.nvim_create_user_command(
            'LeetPy',
            function()
                local id = vim.fn.input("pyleet: enter the problem id: ")
                local handler = io.popen("pyleet info " .. id)
                if handler == nil then
                    print("handler is nil")
                    return
                end
                local info = handler:read("*a")
                if info == "" then
                    vim.print("No information found")
                else
                    require("dsa").most_recent_id = id
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
            function()
                local id = vim.fn.input("goleet: enter the problem id: ")
                local handler = io.popen("goleet info " .. id)
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
            { nargs = 0 }
        )

        vim.api.nvim_create_user_command(
            'LeetRust',
            function()
                local id = vim.fn.input("rsleet: enter the problem id: ")
                local handler = io.popen("rsleet info " .. id)
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
            { nargs = 0 }
        )

        vim.api.nvim_create_user_command(
            'LeetTest',
            function()
                local most_recent_id = require("dsa").most_recent_id
                if most_recent_id == 0 then
                    print("No most recent id found")
                    return
                end
                local leet_exe
                if vim.bo.filetype == "python" then
                    leet_exe = "pyleet"
                elseif vim.bo.filetype == "go" then
                    leet_exe = "goleet"
                elseif vim.bo.filetype == "rust" then
                    leet_exe = "rsleet"
                else
                    print("Unsupported filetype")
                    return
                end
                local handler = io.popen(leet_exe .. " test " .. most_recent_id)
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
            end,
            { nargs = 0 }
        )

        vim.api.nvim_create_user_command(
            'LeetSubmit',
            function()
                local most_recent_id = require("dsa").most_recent_id
                if most_recent_id == 0 then
                    print("No most recent id found")
                    return
                end
                local leet_exe
                if vim.bo.filetype == "python" then
                    leet_exe = "pyleet"
                elseif vim.bo.filetype == "go" then
                    leet_exe = "goleet"
                elseif vim.bo.filetype == "rust" then
                    leet_exe = "rsleet"
                else
                    print("Unsupported filetype")
                    return
                end
                local handler = io.popen(leet_exe .. " submit " .. most_recent_id)
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
            end,
            { nargs = 0 }
        )
    end,
}
