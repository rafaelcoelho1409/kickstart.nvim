-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local plugins = {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

if vim.g.have_nerd_font then
  table.insert(plugins, 'https://github.com/nvim-tree/nvim-web-devicons') -- not strictly required, but recommended
end

vim.pack.add(plugins)

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = '[E]xplorer toggle (NeoTree)', silent = true })

require('neo-tree').setup {
  close_if_last_window = true, -- don't leave the tree as the only open window
  enable_git_status = true, -- git symbols in the tree (like VSCode)
  enable_diagnostics = true, -- LSP diagnostics shown on files/folders
  window = {
    position = 'left', -- persistent left sidebar
    width = 32,
  },
  filesystem = {
    follow_current_file = { enabled = true, leave_dirs_open = true }, -- reveal/track the active file
    use_libuv_file_watcher = true, -- auto-refresh when files change on disk (e.g. Claude Code edits)
    filtered_items = {
      hide_dotfiles = false, -- show .github/, .gitlab-ci.yml, etc.
      hide_gitignored = true, -- hide .terraform/, etc. (press H in the tree to toggle)
    },
    window = {
      mappings = {
        ['\\'] = 'close_window',
        ['H'] = 'toggle_hidden',
      },
    },
  },
}
