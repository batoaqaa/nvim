" Copy this file to $HOME/.vim/ftdetect/kamailio.vim

func! s:cfgType()
   " let max = line("$") > 400 ? 400 : line("$")
   " for n in range(1, max)
   "    if getline(n) =~ '^\s*#!\(KAMAILIO\|OPENSER\|SER\|ALL\|MAXCOMPAT\)'
   "       set filetype=kamailio
   "       return
   "    elseif getline(n) =~ '^\s*#!\(define\|ifdef\|ifndef\|endif\|subst\|substdef\)'
   "       set filetype=kamailio
   "       return
   "    elseif getline(n) =~ '^\s*!!\(define\|ifdef\|ifndef\|endif\|subst\|substdef\)'
   "       set filetype=kamailio
   "       return
   "    elseif getline(n) =~ '^\s*modparam\s*(\s*"[^"]\+"'
   "       set filetype=kamailio
   "       return
   "    elseif getline(n) =~ '^\s*loadmodule\s'
   "       set filetype=kamailio
   "       return
   "    elseif getline(n) =~ '^\s*request_route\s*{\s*'
   "       set filetype=kamailio
   "       return
   "    elseif getline(n) =~ '^\s*route\s*{\s*'
   "       set filetype=kamailio
   "       return
   "    endif
   " endfor
   set filetype=kamailio
   setf cfg
endfunc

au BufNewFile,BufRead *.cfg   call s:cfgType()

