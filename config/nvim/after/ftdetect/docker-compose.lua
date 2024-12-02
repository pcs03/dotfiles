if vim.filetype then
    vim.filetype.add({
        pattern = {
            [".*/docker%-compose%.ya?ml"] = "yaml.docker-compose",
        },
    })
else
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = {
            "*/docker-compose.yml",
            "*/docker-compose.yaml",
        },
        callback = function()
            vim.bo.filetype = "yaml.docker-compose"
        end,
    })
end
