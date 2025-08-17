local M = {}

local function setup(plugins_path)
	local dictdir = vim.fn.expand(vim.fs.joinpath(plugins_path, 'dict'))
	if not vim.uv.fs_stat(dictdir) then
		vim.notify_once('skk-dev/dictを入れてください')
		return {}
	end

	local map, nmap = WagomuBox.map, WagomuBox.nmap

	map({ 'i', 'c', 't' }, '<C-j>', '<Plug>(skkeleton-toggle)')
	nmap('<C-j>', 'i<Plug>(skkeleton-toggle)')

	vim.api.nvim_create_autocmd('User', {
		pattern = 'skkeleton-initialize-pre',
		callback = function()
			local getJisyo = function(name)
				local dictdir = vim.fn.expand(vim.fs.joinpath(plugins_path, 'dict', 'SKK-JISYO.'))
				return vim.fs.normalize(dictdir .. name)
			end
			vim.fn['skkeleton#config'] {
				eggLikeNewline = true,
				globalDictionaries = {
					getJisyo('L'),
					getJisyo('hukugougo'),
					getJisyo('mazegaki'),
					getJisyo('propernoun'),
					getJisyo('station'),
				},
				databasePath = '/tmp/skkeleton.sqlite3',
			}
			vim.fn['skkeleton#register_kanatable']('rom', {
				[ [[z\<Space>]] ] = { [[\u3000]], '' },
				[ [[xn]] ] = { [[ん]], '' },
			})
		end,
	})
end
