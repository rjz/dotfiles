set t_Co=256

set nu!
set ts=2
set shiftwidth=2
set expandtab

set tf

set mouse=a

filetype plugin indent on

colorscheme lucius
LuciusDark

execute pathogen#infect()

" vim-coffee-script settings
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" vagrant
au BufNewFile,BufReadPost Vagrantfile set ft=ruby

" show whitespace
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#af0000
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

set hlsearch

" comments
let @z='i// ^C^C'
let @c='vip :normal @z'

" Set text wrapping at the specified column
function Widthifier(col)
  let &l:textwidth=a:col
  let &l:colorcolumn=a:col+1
endfunction

" line @ 80 chars
autocmd bufreadpre *.js call Widthifier(80)
autocmd bufreadpre *.coffee call Widthifier(80)
autocmd bufreadpre *.sh call Widthifier(80)
autocmd bufreadpre *.rb call Widthifier(80)
autocmd bufreadpre *.md call Widthifier(80)
autocmd bufreadpre *.txt call Widthifier(80)
autocmd bufreadpre *.scala call Widthifier(80)

autocmd bufreadpre *.java set ts=4

autocmd bufreadpre *.md setlocal spell spelllang=en_us

" disable vim-markdown folding
autocmd bufreadpre *.md set nofoldenable

autocmd bufreadpre COMMIT_EDITMSG call Widthifier(72)

highlight ColorColumn ctermbg=0

" try lucius' dark linenumberbg
highlight ColorColumn ctermbg=238

autocmd bufreadpre *.csv set nowrap

map <C-n> :NERDTreeToggle<CR>
execute pathogen#infect()

set autoindent

set tags=tags,.tags,./.tags

" unmap Ctrl-c from :help ft_sql (http://unix.stackexchange.com/a/150769)
let g:ftplugin_sql_omni_key = '<C-j>'

