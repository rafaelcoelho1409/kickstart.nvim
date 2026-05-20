-- Claude Code <-> Neovim workflow helpers (lives outside kickstart core so updates stay clean)
--   1. vim-tmux-navigator: seamless Ctrl-h/j/k/l between nvim splits AND tmux panes
--   2. autoread: reload buffers when files change on disk (e.g. when Claude Code edits them)

-- 1) vim-tmux-navigator -------------------------------------------------------
vim.g.tmux_navigator_no_mappings = 1 -- we map our own below (must be set before the plugin loads)
vim.pack.add { 'https://github.com/christoomey/vim-tmux-navigator' }

vim.keymap.set('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>', { desc = 'Navigate left (nvim/tmux)', silent = true })
vim.keymap.set('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>', { desc = 'Navigate down (nvim/tmux)', silent = true })
vim.keymap.set('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>', { desc = 'Navigate up (nvim/tmux)', silent = true })
vim.keymap.set('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>', { desc = 'Navigate right (nvim/tmux)', silent = true })

-- 2) autoread -----------------------------------------------------------------
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'TermClose', 'TermLeave' }, {
  group = vim.api.nvim_create_augroup('claude-autoread', { clear = true }),
  desc = 'Reload buffers changed on disk (e.g. Claude Code edits)',
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd 'checktime'
    end
  end,
})
