" 在encoding被赋值之前，把旧值保存在termencoding中
" 旧值我查看了下也是utf-8，使用utf-8挺好的
" let &termencoding = &encoding
set encoding=utf-8

" 检测编辑的是哪种文件
set fileencodings=ucs-bom,utf-8,GB2312,latin1,chinese

