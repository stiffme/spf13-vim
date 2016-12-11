REM    Copyright 2014 Steve Francia
REM 
REM    Licensed under the Apache License, Version 2.0 (the "License");
REM    you may not use this file except in compliance with the License.
REM    You may obtain a copy of the License at
REM 
REM        http://www.apache.org/licenses/LICENSE-2.0
REM 
REM    Unless required by applicable law or agreed to in writing, software
REM    distributed under the License is distributed on an "AS IS" BASIS,
REM    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM    See the License for the specific language governing permissions and
REM    limitations under the License.


@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_PATH=%HOME%\.spf13-vim-3
IF NOT EXIST "%APP_PATH%" (
    call git clone -b 3.0 https://github.com/stiffme/spf13-vim.git "%APP_PATH%"
) ELSE (
    @set ORIGINAL_DIR=%CD%
    echo updating spf13-vim
    chdir /d "%APP_PATH%"
    call git pull
    chdir /d "%ORIGINAL_DIR%"
    call cd "%APP_PATH%"
)

call mklink "%HOME%\.vimrc" "%APP_PATH%\.vimrc"
REM call mklink "%HOME%\_vimrc" "%APP_PATH%\.vimrc"
call mklink "%HOME%\.vimrc.fork" "%APP_PATH%\.vimrc.fork"
call mklink "%HOME%\.vimrc.bundles" "%APP_PATH%\.vimrc.bundles"
call mklink "%HOME%\.vimrc.bundles.fork" "%APP_PATH%\.vimrc.bundles.fork"
call mklink "%HOME%\.vimrc.before" "%APP_PATH%\.vimrc.before"
call mklink "%HOME%\.vimrc.before.fork" "%APP_PATH%\.vimrc.before.fork"
call mklink /J "%HOME%\.vim" "%APP_PATH%\.vim"

REM Personal local config
call mklink "%HOME%\.vimrc.local" "%APP_PATH%\personal\.vimrc.local"
call mklink "%HOME%\.vimrc.bundles.local" "%APP_PATH%\personal\.vimrc.bundles.local"
call mklink "%HOME%\.vimrc.before.local" "%APP_PATH%\personal\.vimrc.before.local"

IF NOT EXIST "%APP_PATH%\.vim\bundle" (
    call mkdir "%APP_PATH%\.vim\bundle"
)

IF NOT EXIST "%HOME%/.vim/bundle/vundle" (
    call git clone https://github.com/gmarik/vundle.git "%HOME%/.vim/bundle/vundle"
) ELSE (
  call cd "%HOME%/.vim/bundle/vundle"
  call git pull
  call cd %HOME%
)

call vim  +BundleInstall +BundleClean! +qall

IF EXIST "%HOME%\.vim\bundle\nerdtree\nerdtree_plugin" (
    call mklink "%HOME%\.vim\bundle\nerdtree\nerdtree_plugin\personal.vim" "%APP_PATH%\personal\nerdtree_personal.vim"
)

call md "%HOME%/.vim/plugin"
call mklink "%HOME%\.vim\plugin\bclose.vim" "%APP_PATH%\personal\bclose.vim"
IF EXIST "%APP_PATH%\.vim\bundle\vimproc.vim\lib" (
    call copy "%APP_PATH%\personal\compiled\vimproc_win64.dll" "%APP_PATH%\.vim\bundle\vimproc.vim\lib\vimproc_win64.dll"
)
