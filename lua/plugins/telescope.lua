return  {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',

	dependencies = { 'nvim-lua/plenary.nvim' },

	config = function()
			require('telescope').setup({})
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find files" })
			vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = "Find git files" })

			vim.keymap.set('n', '<leader>pws', function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end, { desc = "Find 'word' string" })

			vim.keymap.set('n', '<leader>pWs', function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end, { desc = "Find 'WORD' string" })

			vim.keymap.set('n', '<leader>ps', function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Find string" })

			vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "View help" })
		end
}
