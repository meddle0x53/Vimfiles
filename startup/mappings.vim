" Annoying, remove:
nnoremap s <Nop>
nnoremap Q <Nop>

" Easily mark a single line in character-wise visual mode
"xnoremap v <esc>0v$
nnoremap vv _v$h

" <space>x -> :X
" For easier typing of custom commands
nnoremap <space>      :call <SID>SpaceMapping(0)<cr>
xnoremap <space> :<c-u>call <SID>SpaceMapping(1)<cr>
function! s:SpaceMapping(visual)
  echo
  let c = nr2char(getchar())
  if a:visual
    normal! gv
  endif
  call feedkeys(':'.toupper(c))
endfunction

" Always move through visual lines:
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" Moving through tabs:
nmap <C-l> gt
nmap <C-h> gT

" Moving through splits:
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

" Faster scrolling:
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

" Moving lines up and down:
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
xnoremap <C-j> :m'>+<CR>gv=gv
xnoremap <C-k> :m-2<CR>gv=gv

" Completion remappings:
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
inoremap <C-o> <C-x><C-o>
inoremap <C-u> <C-x><C-u>
inoremap <C-f> <C-x><C-f>
inoremap <C-]> <C-x><C-]>
inoremap <C-l> <C-x><C-l>
set completefunc=syntaxcomplete#Complete

" For digraphs:
inoremap <C-n> <C-k>

" Cscope commands
nnoremap <C-n>s :lcs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-n>g :lcs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-n>c :lcs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-n>t :lcs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-n>e :lcs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-n>f :lcs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-n>i :lcs find i <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-n>d :lcs find d <C-R>=expand("<cword>")<CR><CR>

" Splitting and joining code blocks
nnoremap sj :SplitjoinSplit<CR>
nnoremap sk :SplitjoinJoin<CR>
" Execute normal vim join if in visual mode
xnoremap sk J

" Easier increment/decrement:
nmap + <C-a>
nmap - <C-x>

" Split and execute any command:
nnoremap __ :split \|<Space>

" Zoom current window in and out:
nnoremap ,, :ZoomWin<cr>

" Open new tab more easily:
nnoremap ,t :tabnew<cr>
nnoremap ,T :tabedit %<cr>gT:quit<cr>

" Standard 'go to manual' command
nmap gm :exe OpenURL('http://google.com/search?q=' . expand("<cword>"))<cr>

" Paste in insert mode
imap <C-p> <Esc>pa

" Returns the cursor where it was before the start of the editing
nmap . .`[

" Delete surrounding function call
" TODO doesn't work for method calls
" TODO relies on braces
nmap dsf F(bdt(ds(

" See startup/commands.vim
nnoremap QQ :Q<cr>

" https://github.com/bjeanes/dot-files/blob/master/vim/vimrc
" For when you forget to sudo.. Really Write the file.
command! W write !sudo tee % >/dev/null

" Run current file -- filetype-specific
nnoremap ! :Run<cr>
xnoremap ! :Run<cr>

" Yank current file's filename
nnoremap gy :call <SID>YankFilename(0)<cr>
nnoremap gY :call <SID>YankFilename(1)<cr>
function! s:YankFilename(linewise)
  let @@ = expand('%:p')

  if (a:linewise) " then add a newline at end
    let @@ .= "\<nl>"
  endif

  let @* = @@
  let @+ = @@

  echo "Yanked filename in clipboard"
endfunction

" Tabularize mappings
" For custom Tabularize definitions see after/plugin/tabularize.vim

nnoremap sa      :call <SID>TabularizeMapping(0)<cr>
xnoremap sa :<c-u>call <SID>TabularizeMapping(1)<cr>
function! s:TabularizeMapping(visual)
  echohl ModeMsg | echo "-- ALIGN -- "  | echohl None
  let align_type = nr2char(getchar())
  if align_type     == '='
    call s:Tabularize('equals', a:visual)
  elseif align_type == '>'
    call s:Tabularize('ruby_hash', a:visual)
  elseif align_type == ','
    call s:Tabularize('commas', a:visual)
  elseif align_type == ':'
    call s:Tabularize('colons', a:visual)
  elseif align_type == '{'
    call s:Tabularize('curly_braces', a:visual)
  end
endfunction
function! s:Tabularize(command, visual)
  normal! mz

  let cmd = "Tabularize ".a:command
  if a:visual
    let cmd = "'<,'>" . cmd
  endif
  exec cmd
  echo

  normal! `z
endfunction
