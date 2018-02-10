execute pathogen#infect()

" Plugins (ls -1 ~/.vim/bundle)
" command-t
" editorconfig-vim
" nerdtree
" vim-colors-solarized
" vim-erlang-runtime
" vim-fugitive
" vim-ruby
" vim-sensible
 
" https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript 
if !exists("g:syntax_on")
    syntax enable
endif

set background=light
colorscheme solarized
filetype plugin indent on

" https://github.com/scrooloose/nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" http://learnvimscriptthehardway.stevelosh.com/chapters/10.html
:inoremap jk <esc>
:inoremap <esc> <nop>

:inoremap <up> <nop>
:inoremap <down> <nop>
:inoremap <left> <nop>
:inoremap <right> <nop>

"https://ctoomey.com/writing/command-t-optimized/
function! Git_Repo_Cdup() " Get the relative path to repo root
    "Ask git for the root of the git repo (as a relative '../../' path)
    let git_top = system('git rev-parse --show-cdup')
    let git_fail = 'fatal: Not a git repository'
    if strpart(git_top, 0, strlen(git_fail)) == git_fail
        " Above line says we are not in git repo. Ugly. Better version?
        return ''
    else
        " Return the cdup path to the root. If already in root,
        " path will be empty, so add './'
        return './' . git_top
    endif
endfunction

function! CD_Git_Root()
    execute 'cd '.Git_Repo_Cdup()
    let curdir = getcwd()
    echo 'CWD now set to: '.curdir
endfunction
nnoremap <LEADER>gr :call CD_Git_Root()<cr>

" Define the wildignore from gitignore. Primarily for CommandT
function! WildignoreFromGitignore()
    silent call CD_Git_Root()
    let gitignore = '.gitignore'
    if filereadable(gitignore)
        let igstring = ''
        for oline in readfile(gitignore)
            let line = substitute(oline, '\s|\n|\r', '', "g")
            if line =~ '^#' | con | endif
            if line == '' | con  | endif
            if line =~ '^!' | con  | endif
            if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
            let igstring .= "," . line
        endfor
        let execstring = "set wildignore=".substitute(igstring,'^,','',"g")
        execute execstring
        echo 'Wildignore defined from gitignore in: '.getcwd()
    else
        echo 'Unable to find gitignore'
    endif
endfunction
nnoremap <LEADER>cti :call WildignoreFromGitignore()<cr>
nnoremap <LEADER>cwi :set wildignore=''<cr>:echo 'Wildignore cleared'<cr>

autocmd FileType make setlocal noexpandtab
:inoremap <S-Tab> <C-V><Tab>

" show the current file name at the top of the terminal window
set title
