" syntax.vim
" @Author:      Thomas Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-11-19.
" @Last Change: 2008-07-10.
" @Revision:    0.0.10

if &cp || exists("loaded_tlib_syntax_autoload")
    finish
endif
let loaded_tlib_syntax_autoload = 1
let s:save_cpo = &cpo
set cpo&vim


function! tlib#syntax#Collect() "{{{3
    let acc = {}
    let syn = ''
    for line in tlib#cmd#OutputAsList('syntax')
        if line =~ '^---'
            continue
        elseif line =~ '^\w'
            let ml = matchlist(line, '^\(\w\+\)\s\+\(xxx\s\+\(.*\)\|\(cluster.*\)\)$')
            if empty(ml)
                echoerr 'Internal error: '. string(line)
            else
                let [m_0, syn, m_1, m_def1, m_def2; m_rest] = ml
                let acc[syn] = [empty(m_def1) ? m_def2 : m_def1]
            endif
        else
            call add(acc[syn], matchstr(line, '^\s\+\zs.*$'))
        endif
    endfor
    return acc
endf


" :def: function! tlib#syntax#Names(?rx='')
function! tlib#syntax#Names(...) "{{{3
    TVarArg 'rx'
    let names = keys(tlib#syntax#Collect())
    if !empty(rx)
        call filter(names, 'v:val =~ rx')
    endif
    return names
endf


let &cpo = s:save_cpo
unlet s:save_cpo
