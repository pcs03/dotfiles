return {
	"numToStr/Comment.nvim",
	opts = {
		-- White space between comment and line
		padding = true,
		-- Lines to be ignored while (un)comment
		ignore = nil,
        -- Enable / Disable keybinds
        mappings = {
            basic = true,
            extra = false,
        },
        -- Pre-comment function
        pre_hook = nil,
        -- Post-comment function
        post_hook = nil,
	},
    lazy = false,
}
