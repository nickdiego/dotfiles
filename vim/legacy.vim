" TODO(nickdiego): remove onve fully migrated to built-in LSP.

" Base16 customizations
function! s:base16_customize() abort
  call Base16hi("LineNr", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("PmenuSel", "", "", "", "", "none", "")
endfunction
augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme base16-* call s:base16_customize()
augroup END

" Load from the shell, if any.
if exists('$BASE16_THEME')
    \ && (!exists('g:colors_name') ||
    \     g:colors_name != 'base16-$BASE16_THEME')
  let base16colorspace=256
  colorscheme base16-$BASE16_THEME
endif

" cpp-enhanced-hightlight options:
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_template_highlight = 1

" neovim-only legacy settings:
if has('nvim')
  let g:lsp_pyls_log_path = expand('~/.lsp/pyls.log')
  let g:lsp_gols_log_path = expand('~/.lsp/go-langserver.log')

  let g:LanguageClient_serverStderr = '/tmp/lsp.stderr'
  let g:LanguageClient_echoProjectRoot = 1
  let g:LanguageClient_diagnosticsEnable = 0
  let g:LanguageClient_autoStart = 0
  let g:LanguageClient_serverCommands = {
        \ 'c':      ['clangd', '-j=4'],
        \ 'cpp':    ['clangd', '-j=4'],
        \ 'go':     ['go-langserver', '-logfile', g:lsp_gols_log_path],
        \ 'rust':   ['rustup', 'run', 'stable-x86_64-unknown-linux-gnu', 'rls'],
        \ 'python': ['pylsp', '--log-file', g:lsp_pyls_log_path],
        \ 'lua':    ['lua-lsp'],
        \ 'java':   ['jdtls', '-data', getcwd()],
        \ 'sh':     ['bash-language-server', 'start'],
        \ 'gn':     ['gnls', '--stdio'],
        \ }
  " deoplete configs
  let g:deoplete#enable_at_startup = 1
  call deoplete#custom#option({
        \ 'auto_complete_delay': 100,
        \ 'smart_case': v:true,
        \ })

  " LSP key bindings
  function SetupLSP()
    nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
    nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
    nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
    nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
    nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
    nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
    nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
    nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
    nnoremap <leader>lw :call LanguageClient#workspace_symbol()<CR>
    " Common shortcuts
    " Whoaaa? enter => jump to definition" ? yes! :D
    nnoremap <C-l> :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <CR> :call LanguageClient#textDocument_definition()<CR>
    nnoremap <M-CR> :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
    nnoremap <Backspace> :call LanguageClient#textDocument_references()<CR>

    set completefunc=LanguageClient#complete
    set formatexpr=LanguageClient_textDocument_rangeFormatting()
  endfunction()

  augroup LSP
    autocmd!
    autocmd FileType cpp,c,python,java,gn,sh call SetupLSP()
    autocmd FileType cpp,c,python,java,gn,sh LanguageClientStart
  augroup END

" Supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

endif

