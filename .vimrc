"加载vundle的操作
set nocompatible

filetype off
"使用VUNDLE管理插件:
set rtp+=~/.vim/bundle/vundle
"插件安装位置
call vundle#rc()
Plugin 'gmarik/vundle'
" :PluginList       - 列出所:有已配置的插件
" :PluginInstall    - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件

"个人插件
"主题
Plugin 'altercation/vim-colors-solarized'
"终端下的主题
colorscheme desert

"文件浏览
Plugin 'scrooloose/nerdtree'
let NERDTreeWinPos='left'
let NERDTreeWinSize=30
map <F2> :NERDTreeToggle<CR>

"状态栏增强
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme="badwolf"
set encoding=utf-8
let g:airline_powerline_fonts = 1
set laststatus=2
"关闭空白符检测
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled=0  
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols_branch = ''
let g:airline_symbols_readonly = ''
let g:airline_symbols_linenr = ''
let g:airline_detect_modified=1
let g:airline_detect_paste=1
"函数标签
Plugin 'majutsushi/tagbar'
"快捷键设置
nmap <Leader>tb :TagbarToggle<CR>          
let g:tagbar_ctags_bin='ctags'            "ctags程序的路径
let g:tagbar_width=30                    "窗口宽度的设置
map <F3> :Tagbar<CR>
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"如果是c语言的程序的话，tagbar自动开启


"括号自动补齐
Plugin 'jiangmiao/auto-pairs'
"YCM配置
Plugin 'Valloric/YouCompleteMe'
let g:ycm_collect_identifiers_from_tags_files = 1   "开启YCM基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释与字符串中的内容也用于补全
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  " 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全"
let g:syntastic_ignore_files=[".*\.py$"]
let g:ycm_seed_identifiers_with_syntax = 1                  " 语法关键字补全
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' "加载配置文件
let g:ycm_show_diagnostics_ui = 1                           " 开启语法检查
inoremap <expr> <CR> pumvisible()?"\<C-y>":"\<CR>" |          " 回车即选中当前项
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|     "跳转到定义处,ctrl+j
let g:ycm_min_num_of_chars_for_completion=2                 "从第二个键入字符开始罗列匹配
let g:ycm_warning_symbol = '>*'
call vundle#end()
filetype plugin indent on

"vim基本配置
filetype on "检查文件类型
syntax   on "语法高亮
set nu "显示行号
set showcmd "显示命令行
set showmode "显示模式
set shortmess=atI "不显示援助信息
set confirm "没有保存或文件只读是弹出确认
set mouse=a "鼠标可用

"tab缩进
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

"智能操作
set autoindent   "自动对齐

set smartindent  "智能缩进

set hlsearch	"高亮查找匹配

set foldenable  "允许折叠
"""""""""""""设置折叠”“”“”“”“”“”
set fdm=syntax  "根据语法
nnoremap <space> @=((foldclosed(line('.')<0)?'zc':'zo'))<CR>
"设置键盘映射，通过空格设置折叠
"""""""""""""设置折叠结束“”“”“”“”

"显示
set showmatch	"显示匹配

set background=dark	"背景色

set ruler	"右下角显示光标位置

set cuc "高亮列
set cul "高亮行

set showcmd		"显示输入的命令


"被分割窗口之间显示空白
set fillchars=vert:/
set fillchars=stl:/
set fillchars=stlnc:/

"编译程序的配置

"编译gcc
function! CompileGcc() 
    echo  "gcc Compiling..."                     
    let compilecmd="!gcc "
    let compileflag="-o %<"  " %<为不带后缀的文件名
    if search("mpi\.h") !=0
        let compilecmd = "!mpicc "  "并行程序的编译命令
    endif
    "下面的链接标志，为使用第三方库是需要链接的命令
    ".号为连接字符串
    if search("pthread\.h") !=0
        let compileflag .= "-lpthread "
    endif
    if search("math\.h") !=0
        let compileflag .="-lm "
    endif
    "...按需要增加
    "运行命令：gcc file.c -o file -lmylibrary
    exec compilecmd."% ".compileflag
endfunction

"编译g++
function! CompileGpp() 
        echo "g++ Compiling..."
        let compilecmd="!g++ "
        let compileflag="-o %<"  " %<为不带后缀的文件名
        if search("mpi\.h") !=0
        let compilecmd = "!mpi++ "
        "并行程序的编译命令
        endif
        "下面的链接标志，为使用第三方库是需要链接的命令
        ".号为连接字符串
        if search("pthread\.h") !=0
        let compileflag .="-lpthread "
        endif
        if search("math\.h")!=0
        let compileflag .="-lm "
        endif
        "...按需要增加
        "运行命令：gcc file.c -o file -lmylibrary
        exec compilecmd."% ".compileflag
endfunction

"python
function! RunPython()
    exec "!python %"
endfunction

"java
function! CompileJava()
    exec "!javac %"
endfunction

"编译代码
function! CompileCode() 
    exec "w"
    if &filetype == "cpp"
        exec "call CompileGpp()"
    elseif &filetype == "c"
        exec "call CompileGcc()"
    elseif &filetype == "python"
        exec "call RunPython()"
    elseif &filetype == "java"
        exec "call CompileJava()"
    endif
endfunction
"运行代码
function!  Run()
    if search("mpi\.h") !=0
        exec "!mpirun -np 4 ./%<"
    elseif &filetype == "cpp"
        exec "!./%<"
    elseif &filetype == "c"
        exec "!./%<"
    elseif &filetype == "python"
        exec "call RunPython()" 
    elseif &filetype == "java"
        exec "!java %<"
    endif
endfunction

"调试C/C++程序
noremap <F5> :call DebugCfamily() <CR>
function! DebugCfamily()
    echo "Debuging"
    exec "w"
    if search("mpi\.h") !=0
        if &filetype="c"
            let CompileCmd="!mpicc "
        elseif &filetype="cpp"
            let CompileCmd="!mpi++ "
        endif
        let Run="!mpirun -np 4 %<"
        "运行并行程序
        exec CompileCmd."-g % -o %<"
        exec "!gdb ".Run
    else
        if &filetype=="c"
            let CompileCmd="!gcc "
        elseif &filetype=="cpp"
            let CompileCmd="!g++ "
        endif
        let Run="!%<"
        "运行
        exec CompileCmd."-g % -o %<"
        exec "!gdb ".Run
    endif
endfunction

"编译加运行
nnoremap <C-F5> :call CompileAndRun() <CR>
function! CompileAndRun()
    exec "call CompileCode()"
    exec "call Run()"
endfunction




"Gvim 配置
if has("gui_running")
    colorscheme solarized
endif
set guifont=DejaVu\Sans\Mono\15
set guioptions=aegic
