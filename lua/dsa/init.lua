return {
    setup = function()
        print("DSA setup")
        vim.api.nvim_create_user_command(
            'DSAPyLeet',
            function(id)
                print(string.format("updated version %s", id))
            end,
            { nargs = 1 }
        )
    end,
}

