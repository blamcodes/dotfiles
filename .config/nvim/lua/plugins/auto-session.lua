return {
    {
        'echasnovski/mini.sessions',
        version = false,
        config = function()
            require('mini.sessions').setup({
                autoread = false,
            })
        end
    },
}
