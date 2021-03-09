## stow应对的需求

> Stow 使用的方法是将每个软件包安装到自己的目录树中，然后使用符号链接使它看起来像文件一样安装在公共的目录树中。

1. [GNU stow](https://www.gnu.org/software/stow/)本来是为了用于管理软件包安装以及多版本共存的一个程序。
2. 这给使用源码安装程序带来便利。
3. 管理家目录下的dotfiles文件。



## 使用stow管理dotfiles

1. 通过stow来管理家目录下的dotfiles是个不错的选择，可以参考：[【译】使用 GNU stow 管理你的点文件](https://farseerfc.me/zhs/using-gnu-stow-to-manage-your-dotfiles.html)

2. 官方文档不一定会看，但同样给出：[GNU Stow](https://www.gnu.org/software/stow/)

3. 用stow来管理dotfile的视频演示：[用stow来管理dotfile](https://www.bilibili.com/video/BV1bz411v7CS?from=search&seid=15625774507677522171)

4. 使用bash函数来简化操作：[使用GNU stow统一管理用户目录下那些隐藏的配置文件](https://blog.swineson.me/zh/use-gnu-stow-to-manage-dot-started-config-files-in-your-home-directory/)

   ```bash
   # 查看家目录下有多少隐藏文件
   ls -ald ~/.* | grep -v ^l | tee >(wc -l)
   
   export DOTFILES=~/dotfiles
   
   dotfiles-count() {
           pushd >/dev/null 2>&1
           cd $HOME
           ls -ald .* | grep -v ^l | tee >(wc -l)
           popd >/dev/null 2>&1
   }
   
   dotfiles-init() {
           pushd >/dev/null 2>&1
           cd $HOME
           ls -ald .$1*;
           mkdir -p $DOTFILES/$1;
           mv .$1* $DOTFILES/$1;
           stow --dir=$DOTFILES --target=$HOME -vv $1
           popd >/dev/null 2>&1
   }
   
   dotfiles-rebuild() {
           stow --dir=$DOTFILES --target=$HOME -vv $@
   }
   ```

   > 比如我们要处理来自vim的配置文件，只需要运行dotfiles-init vim ，一切就自动完成。
   >
   > 想用Git管理配置文件？没问题，去DOTFILES 下面git init 一下。
   >
   > 新环境，dotfiles-rebuild * 就好。

   stow 还会阻止你错误地覆盖文件：如果目标文件已经存在，并且没有指向 stow 目录中的包时，它将拒绝创建符号链接。 这种情况在 stow 术语中称为冲突。

   我的配置文件很少。虽然更换电脑而重新配置系统是间麻烦的事情：[ubuntu最小安装之后我做的事情](https://blog.csdn.net/sinat_38816924/article/details/96335986)

   我暂时也没有好办法。也许Arch中有吧。

   

## 使用stow管理源码安装的软件

对于源码安装，没有`make uninstall` 是个令人头疼的事情。可以使用stow处理，也可以使用checkinstall。

参考1：[如何使用 GNU Stow 来管理从源代码安装的程序和点文件 ](https://linux.cn/article-9467-1.html)

```bash
cd x264 && ./configure --prefix=/usr/local/stow/libx264
make
make install
stow libx264
# stow -d libx264
```

参考2：[checkinstall包的使用](https://www.cnblogs.com/yandufeng/p/5973708.html)

```bash
./configure
make
checkinstall
```

挺有啥意思。从不同的角度，处理问题。

也许厉害的计算机er，遇到问题的时候，总是可以通过代码一劳永逸的解决问题吧。

致敬那些写代码解决问题的人～



## 使用协议

浏览github，经常会看到仓库使用了MIT，GPL协议等。

浏览博客，经常会看到(CC 4.0 BY-SA )这样的版权协议。

它们分别是什么，有什么区别，如何使用呢？

参见：[如何选择开源许可证？-- 阮一峰](https://www.ruanyifeng.com/blog/2011/05/how_to_choose_free_software_licenses.html) | [知识共享许可协议 -- wiki](https://zh.wikipedia.org/wiki/%E7%9F%A5%E8%AF%86%E5%85%B1%E4%BA%AB%E8%AE%B8%E5%8F%AF%E5%8D%8F%E8%AE%AE) | [如何为自己的 Github 项目选择开源许可证？](https://zhuanlan.zhihu.com/p/51331026)