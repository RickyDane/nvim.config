:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
syntax enable
:set termguicolors
:set updatetime=50
:set modifiable

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

" LSP Support
Plug 'neovim/nvim-lspconfig'             " Required
Plug 'williamboman/mason.nvim'           " Optional
Plug 'williamboman/mason-lspconfig.nvim' " Optional

" Autocompletion
Plug 'hrsh7th/nvim-cmp'         " Required
Plug 'hrsh7th/cmp-nvim-lsp'     " Required
Plug 'L3MON4D3/LuaSnip'         " Required

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
Plug 'rust-lang/rust.vim'

Plug 'famiu/feline.nvim' 

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-web-devicons'

" Autocompletion with codeium
Plug 'Exafunction/codeium.vim'

call plug#end()

nnoremap <silent>	<C-f> :NERDTreeFocus<CR>
nnoremap <silent>	<C-t> :NERDTreeToggle<CR>
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
let g:NERDTreeDirArrowCollapsible="o"
let g:rustfmt_autosave=1

lua <<EOF
	vim.cmd('colorscheme rose-pine')

	require'nvim-treesitter.configs'.setup {
		ensure_installed = { "javascript", "rust", "c", "lua", "vim", "vimdoc", "query", "python", "dart" },
		auto_install = true,
		highlight = {
			enable = true,
		},
	}

	local lsp = require('lsp-zero').preset({})

	lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({buffer = bufnr})
	end)

	lsp.setup()

	-- You need to setup `cmp` after lsp-zero
	local cmp = require('cmp')
	local cmp_action = require('lsp-zero').cmp_action()

	cmp.setup({
	mapping = {
		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({select = false}),

		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),
	}
	})
	

	-- Status bar
	require('feline').setup()
	require('feline').winbar.setup()
EOF
