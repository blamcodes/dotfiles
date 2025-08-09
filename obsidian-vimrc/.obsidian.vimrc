" .obsidian.vimrc
"
" A small .vimrc for Obsidian vim bindings
"
" To enable this file, you must install the Vimrc Support plugin for Obsidian:
" https://github.com/esm7/obsidian-vimrc-support
"_________________________________________________________________________

" Yank to system clipboard
set clipboard=unnamed 

" Quickly remove search highlights
nmap <F9> :nohl

" Remap ESC
imap jk <Esc> 

unmap <Space>
"________________________________________
" Navigation
"________________________________________

"j and k navigate visual lines rather than logical ones
nmap j gj 
nmap k gk
" Go to beginning and ending of lines.
nmap H ^
nmap L $

" Tab Navigation
exmap tabnext obcommand workspace:next-tab
nmap gt :tabnext
exmap tabprev obcommand workspace:previous-tab
nmap gT :tabprev

" Link Navigation
exmap followlink obcommand editor:follow-link
nmap gd :followlink
exmap forward obcommand app:go-forward
nmap <C-i> :forward
exmap back obcommand app:go-back
nmap <C-o> :back

" Jump to next/previous Markdown header
exmap nextHeading jsfile mdHelpers.js {jumpHeading(true)}
exmap prevHeading jsfile mdHelpers.js {jumpHeading(false)}
nmap ]] :nextHeading
nmap [[ :prevHeading

" Navigate next/previous links with Tab/Shift + Tab
exmap nextLink jsfile mdHelpers.js {jumpNextLink(true)}
exmap prevLink jsfile mdHelpers.js {jumpNextLink(false)}
nmap <Tab> :nextLink
nmap <S-Tab> :prevLink

exmap followlink obcommand editor:follow-link
nmap <CR> :followlink

"________________________________________
" Search Commands
"________________________________________
exmap globalSearch obcommand global-search:open
nmap <Space><Space>s :globalSearch
exmap search obcommand editor:open-search
nmap <Space>s :search

"________________________________________
" Editor Commands
"________________________________________
" window controls
exmap wq obcommand workspace:close
exmap q obcommand workspace:close
nmap <Space>q :q

exmap focusRight obcommand editor:focus-right
nmap <C-w>l :focusRight

exmap focusLeft obcommand editor:focus-left
nmap <C-w>h :focusLeft

exmap focusTop obcommand editor:focus-top
nmap <C-w>k :focusTop

exmap focusBottom obcommand editor:focus-bottom
nmap <C-w>j :focusBottom

exmap splitVertical obcommand workspace:split-vertical
nmap <C-w>v :splitVertical

exmap splitHorizontal obcommand workspace:split-horizontal
nmap <C-w>s :splitHorizontal

" New File
exmap newfile obcommand file-explorer:new-file
nmap <Space>n :newfile

" Emulate Folding https://vimhelp.org/fold.txt.html#fold-commands
exmap togglefold obcommand editor:toggle-fold
nmap zo :togglefold
nmap zc :togglefold
nmap za :togglefold

exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall

exmap foldall obcommand editor:fold-all
nmap zM :foldall

" Open File Explorer
exmap fileexplorer obcommand file-explorer:open
nmap <Space>f :fileexplorer

" Map pasteinto to Alt-p
map <Space><Space>p :pasteinto

" Open quick switcher
exmap quickswitcher obcommand switcher:open
nmap <Space>o :quickswitcher

" Open Command Palette
exmap commandpalette obcommand command-palette:open
nmap <Space>p :commandpalette

" " Surround links automatically
" exmap surround_wiki surround [[ ]]
" map [[ :surround_wiki