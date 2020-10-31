function! OpenGithub(remote_url)
  " let s:git_url = GetRemoteUrl()
  silent! execute "!open " . a:remote_url | redraw!
endfunction

function! GetCurrentGitBranch()
  return substitute(system("git rev-parse --abbrev-ref HEAD"), "\\n", "", "")
endfunction

function! GetOriginUrl()
  let s:originurl = system("git remote get-url origin")
  return substitute(s:originurl, "\\.git\\n", "", "")
endfunction

function! GetCurrentLine()
  return substitute(line("."), "\\n", "", "")
endfunction

function! GetCurrentFilePath()
  return substitute(expand("%p:."), "\\n", "", "")
endfunction

function! GetNormalRemoteUrl()
  let s:remoteurl = GetOriginUrl() . "/blob/" . GetCurrentGitBranch() . "/" .
        \ GetCurrentFilePath() . "\\#L" . GetCurrentLine()
  return s:remoteurl
endfunction

function! GetVisualRemoteUrl() range
  let s:remote_url = GetOriginUrl() . "/blob/" . GetCurrentGitBranch() . "/"
        \ . GetCurrentFilePath() . "\\#L" . a:firstline . "\\-L" . a:lastline
  silent! execute "!open " . s:remote_url | redraw!
endfunction

function! Demo()
  let branches = sort(systemlist("git branch"))
  let remappedbranches = map(branches,
        \ {key, val -> substitute(val, '\**\s', '', 'g')})
  let s:branchname = input("Please enter a branch name to use: ")
  if index(remappedbranches, s:branchname) != -1
    call GetBranchName()
  else
    echo "Branch is not valid"
  endif
endfunction

function! GetBranchName()
  echo s:branchname
endfunction

" nnoremap <leader>go :call OpenGithub(GetNormalRemoteUrl())<CR>
vnoremap <leader>go :call GetVisualRemoteUrl()<CR>
