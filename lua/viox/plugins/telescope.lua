return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",

  dependencies = {
    'nvim-lua/plenary.nvim', -- some lua function that telescope needs
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- algorithms on c (for performance)
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })

    -- Telescope live_grep in git root from kickstart
    -- Function to find the git root directory based on the current buffer's path
    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()
      -- If the buffer is not associated with a file, return nil
      if current_file == '' then
        current_dir = cwd
      else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
      end

      -- Find the Git root directory from the current file's path
      local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
      if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
      end
      return git_root
    end

    -- Custom live_grep function to search in git root
    local function live_grep_git_root()
      local git_root = find_git_root()
      if git_root then
        require('telescope.builtin').live_grep {
          search_dirs = { git_root },
        }
      end
    end

    vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

    telescope.load_extension("fzf")

    vim.keymap.set(
      'n',
      '<leader><space>',
      require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    local telBuiltin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>sf', telBuiltin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>gf', telBuiltin.git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sw', telBuiltin.grep_string, { desc = '[S]earch current [W]ord' })

    -- grep search ( use grep recursive search in the directories  )
    vim.keymap.set('n', '<leader>sg', telBuiltin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })

    vim.keymap.set('n', '<leader>sd', telBuiltin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sh', telBuiltin.help_tags, { desc = '[S]earch [H]elp' })

    -- Lists all of the community maintained pickers built into Telescope
    vim.keymap.set('n', '<leader>ss', telBuiltin.builtin, { desc = '[S]earch [S]elect Telescope' })
  end
}
