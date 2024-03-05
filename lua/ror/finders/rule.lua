local M = {}

function M.find()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local previewers = require("telescope.previewers")
	local conf = require("telescope.config").values

	local root_path = vim.fn.getcwd()
	local rules = vim.split(vim.fn.glob(root_path .. "app/models/concerns/tasks/state_licenses/**/*rb"), "\n")
	local parsed_rules = {}
	for _, value in ipairs(rules) do
		-- take only the filename without extension
		if value ~= "" then
			local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
			table.insert(parsed_rules, parsed_filename)
		end
	end

	if #parsed_rules > 0 then
		local opts = {}
		pickers
			.new(opts, {
				prompt_title = "Rules",
				finder = finders.new_table({
					results = parsed_rules,
				}),
				previewer = previewers.vim_buffer_cat.new(opts),
				sorter = conf.generic_sorter(opts),
			})
			:find()
	end
end

return M
