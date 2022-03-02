# terminal mode
## vim打开多窗口、多文件
vim file1 file2 ...
vim -On file1 file2 ... # 垂直打开
vim -on file1 file2 ... # 水平打开

## only read mode 
view file1

# insert mode
:e file2		# 当前窗口打开
:sp file2 		# 水平切分窗口
:vsp file2 		# 垂直切分窗口

Ctrl + 6		# switch file1,file2
:ls			# list open files
:bn			# switch file-n

## tabe相关
:tabe file...		# new table file...
g t			# goto next tab
g T			# goto prev tab

:verbose set mouse	# 查看最后在哪里配置的mouse
:w ! sudo tee %		# 强制保存

:vert diffsplit file2	# 比较两个文件不同
:5,15s/dog/cat/g	# 替换行内字符串

## 设置空格或回车可见
:setlocal list
:set listchars=tab:>~,trail:.

# normal mode
r 			# 单个字符替换
R 			# 替换模式
V			# 行 视图模式
e			# 移到单词末尾
b			# 移到单词开头
''			# 光标回到上一次的位置
%			# 跳到括号匹配处

<C-e> / <C-y>		# 屏幕向下(上)移动一行
zz			# 将当前行移动到屏幕的中间
zt 			# 将当前行移到屏幕顶部
zb 			# 将当前行移到屏幕底部
ZZ			# 保存并退出
gf			# 打开头文件
gD			# 跳到局部变量的定义处
[[ 			# 跳转至上一个函数(要求代码块中'{'必须单独占一行)
]] 			# 跳转至下一个函数(要求代码块中'{'必须单独占一行)


<C-w-w>			# switch window
<C-w-r>			# swap window

<C-a>			# add 1
<C-x>			# sub 1
<C-r>			# 撤销回退

## 折叠相关
z f %			# 折叠
z o			# 展开
z c			# 折叠

<C-w> s     		# 水平新建窗口
<C-w> v     		# 垂直新建窗口
<C-g>			# 显示文件信息
<C-o>			# 回到上次打开的文件



## plugins
### vim-markdown
zr: reduces fold level throughout the buffer
zR: opens all folds
zm: increases fold level throughout the buffer
zM: folds everything all the way
za: open a fold your cursor is on
zA: open a fold your cursor is on recursively
zc: close a fold your cursor is on
zC: close a fold your cursor is on recursively


# gdb
```
<C-L>			# clear screen
(gdb) p /x *p@100	# print array of length
```
