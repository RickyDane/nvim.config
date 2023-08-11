:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
syntax enable
:set termguicolors
:set updatetime=50

call plug#begin()

Plug 'preservim/nerdtree' " dir / file tree
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'romgrk/barbar.nvim'
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
Plug 'rose-pine/neovim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mbbill/undotree'

" Tabnine / AI Autocompletion
Plug 'codota/tabnine-nvim', { 'do': '.dl_binaies.sh' }

" LSP Support
Plug 'neovim/nvim-lspconfig'             " Required
Plug 'williamboman/mason.nvim',          " Optional
Plug 'williamboman/mason-lspconfig.nvim' " Optional

" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

Plug 'famiu/feline.nvim' 

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-web-devicons'

call plug#end()

nnoremap <silent>	<C-f> :NERDTreeFocus<CR>
nnoremap <silent>	<A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>   <A-.> <Cmd>BufferNext<CR>

nnoremap <silent>   <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>   <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>   <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>   <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>   <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>   <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>   <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>   <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>   <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>   <A-c> <Cmd>BufferClose<CR>

nnoremap <silent>	<A-u> <Cmd>UndotreeToggle<CR>	

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

lua <<EOF
	vim.cmd('colorscheme rose-pine')

	require'nvim-treesitter.configs'.setup {
		ensure_installed = { "javascript", "rust", "c", "lua", "vim", "vimdoc", "query" },
		auto_install = true,
		highlight = {
			enable = true,
		},
	}

	-- LSP Setup
	local lsp = require('lsp-zero').preset({})

	lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({buffer = bufnr})
	end)

	-- (Optional) Configure lua language server for neovim
	require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

	lsp.setup()
	
	-- Tabnine activation
	require('tabnine').setup({
		disable_auto_comment=true,
		accept_keymap="<Tab>",
		dismiss_keymap = "<C-]>",
		debounce_ms = 800,
		suggestion_color = {gui = "#808080", cterm = 244},
		exclude_filetypes = {"TelescopePrompt"},
		log_file_path = nil, -- absolute path to Tabnine log file
	})

	-- Status bar
	require('feline').setup()
	require('feline').winbar.setup()
EOF
