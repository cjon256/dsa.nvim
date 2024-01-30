local M

M.pyleet = function(problem_id)
    local info = vim.cmd [[
    if executable('pyleet') == 1
        echo system('pyleet ' .. a:problem_id)
    else
        echo 'pyleet is not installed'
    ]]
    print("Hello from pyleet")
    vim.print(info)
end

return M
