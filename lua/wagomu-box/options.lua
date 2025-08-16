local M = {}

function M.apply()
  vim.g.mapleader = ' '

  local set = vim.opt
  set.backspace = {
    'indent',
    'eol',
    'start'
  }
  set.clipboard = 'unnamedplus,unnamed'
  set.cmdheight = 0
  set.encoding = 'utf-8'
  set.expandtab = false
  set.fileencoding = 'utf-8'
  set.fileencodings = 'utf-8,euc-jp,cp932'
  set.fillchars = {
    stl = '─',
    stlnc = '─',
    diff = '∙',
    eob = ' ',
    fold = '·',
    horiz = '─',
    horizup = '┴',
    horizdown = '┬',
    vert = '│',
    vertleft = '┤',
    vertright = '├',
    verthoriz = '┼',
  }
  set.foldcolumn = '1'
  set.foldenable = true
  set.foldlevel = 99999
  set.foldlevelstart = 99999
  set.foldtext = [[v:lua.vim.treesitter.foldtext()]]
  set.helplang = 'ja,en'
  set.hidden = true
  set.hlsearch = true
  set.ignorecase = true
  set.incsearch = true
  set.laststatus = 0
  set.list = true
  set.listchars = {
    eol = '↴',
    tab = '▷⋯',
    trail = '»',
    space = '⋅',
    nbsp = '⦸',
    extends = '»',
    precedes = '«',
  }
  set.shiftwidth = 2
  set.signcolumn = 'yes'
  set.smartcase = true
  set.softtabstop = 2
  set.statusline = '─'
  set.tabstop = 2
  set.undofile = true
  set.undodir = vim.fn.stdpath('data') .. '/undo'
  set.wrap = false

  if vim.fn.executable('rg') == 1 then
    vim.opt.grepprg = table.concat({
      'rg',
      '--vimgrep',
      '--trim',
      '--hidden',
      [[--glob='!.git']],
      [[--glob='!*.lock']],
      [[--glob='!*-lock.json']],
      [[--glob='!*generated*']],
    }, ' ')
    vim.opt.grepformat = '%f:%l:%c:%m'
  end
end

return M
