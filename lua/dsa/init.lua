-- luacheck: globals vim
return {
    most_recent_id = 0,
    setup = function()
        vim.api.nvim_create_user_command(
            'LeetPy',
            function(id)
                id = id.args
                if id == nil then
                    print("LeetPy requires an argument")
                    return
                end
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
            { nargs = 1 }
        )

        vim.api.nvim_create_user_command(
            'LeetPyPrompt',
            function()
                local id = vim.fn.input("pyleet: enter the problem id: ")
                vim.cmd("LeetPy " .. id)
            end,
            { nargs = 0 }
        )

        vim.api.nvim_create_user_command(
            'LeetGo',
            function(id)
                id = id.args
                if id == nil then
                    print("LeetGo requires an argument")
                    return
                end
                local handler = io.popen("goleet info " .. id)
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
            { nargs = 1 }
        )

        vim.api.nvim_create_user_command(
            'LeetGoPrompt',
            function()
                local id = vim.fn.input("goleet: enter the problem id: ")
                vim.cmd("LeetGo " .. id)
            end,
            { nargs = 0 }
        )

        vim.api.nvim_create_user_command(
            'LeetRust',
            function(id)
                id = id.args
                if id == nil then
                    print("LeetRust requires an argument")
                    return
                end
                local handler = io.popen("rsleet info " .. id)
                if handler == nil then
                    print("handler is nil")
                    return
                end
                local info = handler:read("*a")
                if info == "" then
                    print("No information found")
                else
                    require("dsa").most_recent_id = id
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
            'LeetRustPrompt',
            function()
                local id = vim.fn.input("rsleet: enter the problem id: ")
                vim.cmd("LeetRust " .. id)
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

        vim.api.nvim_create_user_command(
            'LeetOpen',
            function()
                local most_recent_id = require("dsa").most_recent_id
                if most_recent_id == 0 then
                    print("No most recent id found")
                    return
                end
                vim.cmd('silent exec "!leetopen ' .. most_recent_id .. '"')
            end,
            { nargs = 0, desc = "Open the problem in the browser" }
        )

        vim.api.nvim_create_user_command(
            'LeetNext',
            function()
                local handler = io.popen("grind75 next")
                if handler == nil then
                    print("cannot call grind75")
                    return
                end
                local id = handler:read("*a")
                if id == "" then
                    print("No information found")
                    return
                end

                -- check if the current filetype is python, go, or rust
                local filetype = vim.bo.filetype
                local supported_types = { "python", "go", "rust" }
                if not vim.tbl_contains(supported_types, filetype) then
                    filetype = vim.fn.input("Enter the filetype: ")
                end

                local leet_exe
                if filetype == "python" then
                    leet_exe = "LeetPy"
                elseif filetype == "go" then
                    leet_exe = "LeetGo"
                elseif filetype == "rust" then
                    leet_exe = "LeetRust"
                else
                    print("Unsupported filetype")
                    return
                end
                vim.cmd(leet_exe .. " " .. id)
            end,
            { nargs = 0 }
        )

        vim.api.nvim_create_user_command(
            'LeetNextOpen',
            function()
                vim.cmd("LeetOpen")
                vim.cmd("LeetNext")
            end,
            { nargs = 0 }
        )
    end,
}
