" statusline
let g:lightline = {
            \ 'colorscheme': 'gruvbox8',
            \ 'active': {
            \	'left': [['mode', 'paste', 'modified'], ['gitbranch'], ['filename']],
            \	'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'LightLineGitBranch',
            \   'filename': 'LightlineTabFilename',
            \	'functionName': 'LightlineFunctionName',
            \   'fileformat': 'LightLineFileFormat',
            \   'fileencoding': 'LightLineFileEncoding',
            \   'filetype': 'LightLineFileType',
            \}
            \}

function! LightlineTabFilename()
    let fname = expand('%')
    return fname =~ '__Tagbar__' ? 'Tagbar' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ ('' != fname ? fname : '[No Name]')
endfunction

function! LightlineFunctionName()
    return IsIgnoredWindow() ? '' : tagbar#currenttag("%s", "", 'f', 'nearest-stl')
endfunction

function! LightLineGitBranch()
    if IsIgnoredWindow()
        return ''
    endif
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction

function! LightLineFileFormat()
    return IsIgnoredWindow() ? '' : &fileformat
endfunction()

function! LightLineFileEncoding()
    return IsIgnoredWindow() ? '' : &fileencoding
endfunction()

function! LightLineFileType()
    return IsIgnoredWindow() ? '' : &filetype
endfunction()

function! IsIgnoredWindow()
    return (&filetype == 'tagbar' || &filetype == 'nerdtree')
endfunction

set laststatus=2

