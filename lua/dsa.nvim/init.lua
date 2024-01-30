local M

M.pyleet = function(problem_id)
    local command = string.format(
    "if executable('pyleet') == 1\n pyleet %s\nelse\n echo 'pyleet is not installed'\nendif\n", problem_id)
    local info = vim.fn.system(command)
    print("Hello from pyleet")
    vim.print(info)
end

return M
