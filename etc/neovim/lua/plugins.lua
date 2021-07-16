vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
  -- package manager

  use 'wbthomason/packer.nvim'

  -- appearance

  use 'kyazdani42/nvim-web-devicons'

  use {
    'cocopon/iceberg.vim',
    config = function()
      vim.cmd('colorscheme iceberg')
    end,
  }

  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', },
    event = 'VimEnter',
    config = function()
      require('lualine').setup({
        options = {
          theme = 'iceberg_dark',
          icon_enabled = true,
        },
        sections = {
          lualine_a = { { 'mode', upper = true } },
          lualine_b = { { 'branch' } },
          lualine_c = { { 'filename', file_status = true } },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = { },
          lualine_b = { },
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = { },
          lualine_z = { },
        },
      })
    end,
  }

  -- fuzzy finder

  use {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
    setup = function()
      local utils = require('utils')
      utils.map('n', '<leader><leader>', '<cmd>Telescope commands<cr>')
      utils.map('n', '<leader>/',        '<cmd>Telescope live_grep<cr>')
      utils.map('n', '[buffer]b',        '<cmd>Telescope buffers<cr>')
      utils.map('n', '[execute]r',       '<cmd>Telescope command_history<cr>')
      utils.map('n', '[file]f',          '<cmd>Telescope find_files<cr>')
      utils.map('n', '[file]j',          '<cmd>Telescope file_browser<cr>')
      utils.map('n', '[file]r',          '<cmd>Telescope oldfiles<cr>')
      utils.map('n', '[project]f',       '<cmd>Telescope git_files<cr>')
      utils.map('n', '[project]s',       '<cmd>Telescope live_grep<cr>')
      utils.map('n', '[search]r',        '<cmd>Telescope search_histroy<cr>')
      utils.map('n', '[search]s',        '<cmd>Telescope current_buffer_fuzzy_find<cr>')
    end,
    config = function()
      require('telescope').setup({
        pickers = {
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ['<c-d>'] = require('telescope.actions').delete_buffer,
                ['<c-d>'] = 'delete_buffer',
              },
              n = {
                ['<c-d>'] = require('telescope.actions').delete_buffer,
              }
            }
          }
        }
      })
    end,
  }

  -- terminal

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<c-z>]],
        direction = 'float',
        shade_terminals = true,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            background = 'Normal',
            border = 'Normal',
          },
        },
      })
    end,
  }

  -- git

  use {
    'tpope/vim-fugitive',
    cmd = { 'Gblame', 'Git' },
    setup = function()
      local utils = require('utils')
      utils.map('n', '[git]b', '<cmd>Gblame<cr>')
      utils.map('n', '[git]s', '<cmd>Git<cr>')
    end,
  }

  use {
    'airblade/vim-gitgutter',
    event = { 'BufEnter' },
    setup = function()
      local utils = require('utils')
      local opts = { noremap = false }
      vim.g.gitgutter_map_keys = 0
      utils.map('n', '[git]n', '<plug>(GitGutterNextHunk)', opts)
      utils.map('n', '[git]p', '<plug>(GitGutterPrevHunk)', opts)
    end,
  }

  -- bookmark

  use {
    'MattesGroeger/vim-bookmarks',
    event = { 'BufEnter' },
    setup = function()
      local utils = require('utils')
      local opts = { noremap = false }
      vim.g.bookmark_no_default_key_mappings = 1
      utils.map('n', '[bookmark]c', '<Plug>BookmarkClear',      opts)
      utils.map('n', '[bookmark]g', '<Plug>BookmarkMoveToLine', opts)
      utils.map('n', '[bookmark]i', '<Plug>BookmarkAnnotate',   opts)
      utils.map('n', '[bookmark]j', '<Plug>BookmarkMoveDown',   opts)
      utils.map('n', '[bookmark]k', '<Plug>BookmarkMoveUp',     opts)
      utils.map('n', '[bookmark]l', '<Plug>BookmarkShowAll',    opts)
      utils.map('n', '[bookmark]m', '<Plug>BookmarkToggle',     opts)
      utils.map('n', '[bookmark]n', '<Plug>BookmarkNext',       opts)
      utils.map('n', '[bookmark]p', '<Plug>BookmarkPrev',       opts)
      utils.map('n', '[bookmark]x', '<Plug>BookmarkClearAll',   opts)
    end,
  }

  -- edit / search / moving

  use {
    'tpope/vim-surround',
    event = { 'BufEnter' },
  }

  use {
    'cohama/lexima.vim',
    event = { 'BufEnter' },
    setup = function()
      local utils = require('utils')
      vim.g.lexima_ctrlh_backspace = 1
      utils.map('i', '<C-l>', "<C-r>=lexima#insmode#leave(1, '<LT>C-G>U<LT>RIGHT>')<CR>")
    end,
  }

  use {
    'alvan/vim-closetag',
    ft = { 'html', 'xhtml', 'phtml', 'php', 'typescriptreact', 'javascriptreact' },
    setup = function()
      vim.g.closetag_filetypes = 'html,xhtml,phtml,php,javascriptreact,typescriptreact'
    end,
  }

  use {
    'gantheory/vim-easymotion',
    event = { 'BufEnter' },
    setup = function()
      local utils = require('utils')
      local opts = { noremap = false }
      vim.g.EasyMotion_do_mapping = 0
      vim.g.EasyMotion_keys = 'dhtnsfgcrlbmwvzaoeui,.py;qjkx'

      utils.map('n', '[search]f', '<Plug>(easymotion-overwin-f2)',   opts)
      utils.map('n', '[search]l', '<Plug>(easymotion-overwin-line)', opts)
      utils.map('n', '[search]w', '<Plug>(easymotion-overwin-w)',   opts)
    end,
  }

  use {
    'preservim/nerdcommenter',
    event = { 'BufEnter' },
    setup = function()
      local utils = require('utils')
      local opts = { noremap = false }
      vim.g.NERDCreateDefaultMappings = 1
      vim.g.NERDSpaceDelims = 1
      utils.map('n', 'gca', '<Plug>NERDCommenterAppend',  opts)
      utils.map('n', 'gcc', '<Plug>NERDCommenterComment', opts)
      utils.map('n', 'gci', '<Plug>NERDCommenterInvert', opts)
      utils.map('n', 'gcs', '<Plug>NERDCommenterSexy',    opts)
      utils.map('x', 'gcc', '<Plug>NERDCommenterComment', opts)
      utils.map('x', 'gci', '<Plug>NERDCommenterInvert', opts)
      utils.map('x', 'gcs', '<Plug>NERDCommenterSexy',    opts)
    end,
  }

  -- filetype

  use 'Shougo/context_filetype.vim'
  use 'osyo-manga/vim-precious'

  use {
    'ekalinin/Dockerfile.vim',
    ft = { 'dockerfile' },
  }

  -- syntax highlighting

  use {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufEnter' },
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
        },
      })
    end,
  }

  -- completion

  use {
    'hrsh7th/nvim-compe',
    event = { 'VimEnter' },
    requires = {
      { 'hrsh7th/vim-vsnip', opt = true },
    },
    setup = function()
      vim.g.vsnip_filetypes = {
        typescriptreact = { 'typescript' }
      }
    end,
    config = function()
      require('compe').setup({
        preselect = 'always',
        source = {
          path = true,
          buffer = true,
          vsnip = true,
          nvim_lsp = true,
          nvim_lua = true
        }
      })

      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
          return vim.fn['compe#confirm']()
        elseif vim.fn.call('vsnip#available', {1}) == 1 then
          return t('<Plug>(vsnip-expand-or-jump)')
        else
          return t('<Tab>')
        end
      end

      local utils = require('utils')
      utils.map('i', '<Tab>',     'v:lua.tab_complete()',    { expr = true })
      utils.map('s', '<Tab>',     'v:lua.tab_complete()',    { expr = true })
      utils.map('i', '<C-Space>', 'compe#complete()',        { expr = true })
      utils.map('i', '<CR>',      [[compe#confirm('<CR>')]], { expr = true })
      utils.map('i', '<C-e>',     [[compe#close('<C-e>')]],  { expr = true })
    end,
  }

  -- language server protocol

  use {
    'neovim/nvim-lspconfig',
    event = { 'VimEnter' },
    config = function()
      local lsp = require('lspconfig');

      local format_async = function(err, _, result, _, bufnr)
        if err ~= nil or result == nil then return end
        if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
          local view = vim.fn.winsaveview()
          vim.lsp.util.apply_text_edits(result, bufnr)
          vim.fn.winrestview(view)
          if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command('noautocmd :update')
          end
        end
      end

      vim.lsp.handlers['textDocument/formatting'] = format_async

      _G.lsp_organize_imports = function()
        local params = {
          command = '_typescript.organizeImports',
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = ''
        }
        vim.lsp.buf.execute_command(params)
      end

      local on_attach = function(client, bufnr)
        vim.cmd('command! LspDef            lua vim.lsp.buf.definition()')
        vim.cmd('command! LspFormatting     lua vim.lsp.buf.formatting()')
        vim.cmd('command! LspCodeAction     lua vim.lsp.buf.code_action()')
        vim.cmd('command! LspHover          lua vim.lsp.buf.hover()')
        vim.cmd('command! LspRename         lua vim.lsp.buf.rename()')
        vim.cmd('command! LspOrganize       lua lsp_organize_imports()')
        vim.cmd('command! LspRefs           lua vim.lsp.buf.references()')
        vim.cmd('command! LspTypeDef        lua vim.lsp.buf.type_definition()')
        vim.cmd('command! LspImplementation lua vim.lsp.buf.implementation()')
        vim.cmd('command! LspDiagLine       lua vim.lsp.diagnostic.show_line_diagnostics()')
        vim.cmd('command! LspDiagNext       lua vim.lsp.diagnostic.goto_next()')
        vim.cmd('command! LspDiagPrev       lua vim.lsp.diagnostic.goto_prev()')
        vim.cmd('command! LspSignatureHelp  lua vim.lsp.buf.signature_help()')

        local utils = require('utils')
        utils.map('n', '<C-k>',       ':LspSignatureHelp<CR>')
        utils.map('n', 'K',           ':LspHover<CR>')
        utils.map('n', '[language]F', ':LspFormatting<CR>')
        utils.map('n', '[language]R', ':LspRename<CR>')
        utils.map('n', '[language]a', ':LspCodeAction<CR>')
        utils.map('n', '[language]d', ':LspDef<CR>')
        utils.map('n', '[language]i', ':LspImplementation<CR>')
        utils.map('n', '[language]l', ':LspDiagLine<CR>')
        utils.map('n', '[language]n', ':LspDiagNext<CR>')
        utils.map('n', '[language]o', ':LspOrganize<CR>')
        utils.map('n', '[language]p', ':LspDiagPrev<CR>')
        utils.map('n', '[language]r', ':LspRefs<CR>')
        utils.map('n', '[language]t', ':LspTypeDef<CR>')

        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_exec([[
            augroup LspAutoCommands
              autocmd! * <buffer>
              autocmd BufWritePost <buffer> LspFormatting
            augroup END
          ]], true)
        end
      end

      lsp.tsserver.setup({
        on_attach = function(client)
          client.resolved_capabilities.document_formatting = false
          on_attach(client)
        end
      })

      lsp.stylelint_lsp.setup({
        settings = {
          stylelintplus = {
            autoFixOnFormat = true,
            autoFixOnSave = true,
          }
        },
        filetypes = { 'css', 'scss' },
        on_attach = on_attach,
      })

      lsp.dockerls.setup({
        on_attach = on_attach
      })

      local filetypes = {
        typescript = 'eslint',
        typescriptreact = 'eslint',
      }

      local linters = {
        eslint = {
          sourceName = 'eslint',
          command = 'eslint_d',
          rootPatterns = { '.eslintrc.js', 'package.json' },
          debounce = 100,
          args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
          parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '${message} [${ruleId}]',
            security = 'security',
          },
          securities = { [2] = 'error', [1] = 'warning' },
        },
      }

      local formatters = {
        prettier = {
          command = 'prettier',
          args = { '--stdin-filepath', '%filepath' }
        },
      }

      local formatFiletypes = {
        typescript = 'prettier',
        typescriptreact = 'prettier',
      }

      lsp.diagnosticls.setup({
        on_attach = on_attach,
        filetypes = vim.tbl_keys(filetypes),
        init_options = {
          filetypes = filetypes,
          linters = linters,
          formatters = formatters,
          formatFiletypes = formatFiletypes,
        },
      })
    end,
  }

end)
