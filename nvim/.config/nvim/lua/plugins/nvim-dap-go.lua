require('dap-go').setup({
    delve = {
        detached = vim.fn.has 'win32' == 0,
    }
})
