vim.api.nvim_create_user_command('DenoCacheUpdate', 'call denops#cache#update(#{reload: v:true})', { nargs = 0 })

vim.api.nvim_create_user_command("SwapClean", function()
  local dirs = vim.opt.directory:get()
  for _, dir in pairs(dirs) do
    for name in vim.iter(vim.fs.dir(dir, { depth = 1 })):filter(function(_, type)
      return type == "file"
    end) do
      local file = vim.fs.joinpath(dir, name)
      vim.print("deleting " .. file)
      vim.fs.rm(file)
    end
  end
end, {})

-- https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(event)
    local dir = vim.fs.dirname(event.file)
    local force = vim.v.cmdbang == 1
    if not vim.bool_fn.isdirectory(dir)
        and (force or vim.fn.confirm('"' .. dir .. '" does not exist. Create?', "&Yes\n&No") == 1) then
      vim.fn.mkdir(vim.fn.iconv(dir, vim.opt.encoding:get(), vim.opt.termencoding:get()), 'p')
    end
  end,
  desc = 'Auto mkdir to save file'
})
