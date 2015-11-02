git config --global user.name "Your Name"
git config --global user.email "email@example.com"

创建空的版本库
mkdir zzh
cd zzh
git init

初始化一个Git仓库，使用git init命令。
添加文件到Git仓库，分两步：
	第一步，使用命令git add <file>，注意，可反复多次使用，添加多个文件；
	第二步，使用命令git commit，完成。

git diff readme.txt
git status
git log
git log --pretty=oneline

回到上一版本
git reset --hard HEAD^
git reflog 记录每一次命令

HEAD指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令git reset --hard commit_id。
	穿梭前，用git log可以查看提交历史，以便确定要回退到哪个版本。
	要重返未来，用git reflog查看命令历史，以便确定要回到未来的哪个版本。

把文件往Git版本库里添加的时候，是分两步执行的：
	第一步是用git add把文件添加进去，实际上就是把文件修改添加到暂存区；
	第二步是用git commit提交更改，实际上就是把暂存区的所有内容提交到当前分支。
	
Git跟踪并管理的是修改，而非文件。
又理解了Git是如何跟踪修改的，每次修改，如果不add到暂存区，那就不会加入到commit中

要关联一个远程库，使用命令git remote add origin git@server-name:path/repo-name.git；
关联后，使用命令git push -u origin master第一次推送master分支的所有内容；

要克隆一个仓库，首先必须知道仓库的地址，然后使用git clone命令克隆。
Git支持多种协议，包括https，但通过ssh支持的原生git协议速度最快。

https://github.com/baoshan-github/bigdata.git

Git鼓励大量使用分支：
	查看分支：git branch
	创建分支：git branch <name>
	切换分支：git checkout <name>
	创建+切换分支：git checkout -b <name>
	合并某分支到当前分支：git merge <name>
	删除分支：git branch -d <name>
	
当Git无法自动合并分支时，就必须首先解决冲突。解决冲突后，再提交，合并完成。
	用git log --graph命令可以看到分支合并图。

开发一个新feature，最好新建一个分支；
	如果要丢弃一个没有被合并过的分支，可以通过git branch -D <name>强行删除。

因此，多人协作的工作模式通常是这样：
	首先，可以试图用git push origin branch-name推送自己的修改；
	如果推送失败，则因为远程分支比你的本地更新，需要先用git pull试图合并；
	如果合并有冲突，则解决冲突，并在本地提交；
	没有冲突或者解决掉冲突后，再用git push origin branch-name推送就能成功！
	如果git pull提示“no tracking information”，则说明本地分支和远程分支的链接关系没有创建，用命令git branch --set-upstream branch-name origin/branch-name。
	这就是多人协作的工作模式，一旦熟悉了，就非常简单。

小结
	查看远程库信息，使用git remote -v；
	本地新建的分支如果不推送到远程，对其他人就是不可见的；
	从本地推送分支，使用git push origin branch-name，如果推送失败，先用git pull抓取远程的新提交；
	在本地创建和远程分支对应的分支，使用git checkout -b branch-name origin/branch-name，本地和远程分支的名称最好一致；
	建立本地分支和远程分支的关联，使用git branch --set-upstream branch-name origin/branch-name；
	从远程抓取分支，使用git pull，如果有冲突，要先处理冲突。

小结
	命令git tag <name>用于新建一个标签，默认为HEAD，也可以指定一个commit id；
	git tag -a <tagname> -m "blablabla..."可以指定标签信息；
	git tag -s <tagname> -m "blablabla..."可以用PGP签名标签；
	命令git tag可以查看所有标签。
	
小结
	命令git push origin <tagname>可以推送一个本地标签；
	命令git push origin --tags可以推送全部未推送过的本地标签；
	命令git tag -d <tagname>可以删除一个本地标签；
	命令git push origin :refs/tags/<tagname>可以删除一个远程标签。
小结
	在GitHub上，可以任意Fork开源仓库；
	自己拥有Fork后的仓库的读写权限；
	可以推送pull request给官方仓库来贡献代码。

小结
	忽略某些文件时，需要编写.gitignore；
	.gitignore文件本身要放到版本库里，并且可以对.gitignore做版本管理！

配置别名

有没有经常敲错命令？比如git status？status这个单词真心不好记。
如果敲git st就表示git status那就简单多了，当然这种偷懒的办法我们是极力赞成的。
我们只需要敲一行命令，告诉Git，以后st就表示status：
$ git config --global alias.st status
好了，现在敲git st看看效果。
当然还有别的命令可以简写，很多人都用co表示checkout，ci表示commit，br表示branch：
$ git config --global alias.co checkout
$ git config --global alias.ci commit
$ git config --global alias.br branch
以后提交就可以简写成：
$ git ci -m "bala bala bala..."
--global参数是全局参数，也就是这些命令在这台电脑的所有Git仓库下都有用。
在撤销修改一节中，我们知道，命令git reset HEAD file可以把暂存区的修改撤销掉（unstage），重新放回工作区。既然是一个unstage操作，就可以配置一个unstage别名：
$ git config --global alias.unstage 'reset HEAD'
当你敲入命令：
$ git unstage test.py
实际上Git执行的是：
$ git reset HEAD test.py
配置一个git last，让其显示最后一次提交信息：
$ git config --global alias.last 'log -1'
这样，用git last就能显示最近一次的提交：
$ git last
commit adca45d317e6d8a4b23f9811c3d7b7f0f180bfe2
Merge: bd6ae48 291bea8
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Thu Aug 22 22:49:22 2013 +0800
    merge & fix hello.py
甚至还有人丧心病狂地把lg配置成了：
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
来看看git lg的效果：
git-lg
为什么不早点告诉我？别激动，咱不是为了多记几个英文单词嘛！
配置文件
配置Git的时候，加上--global是针对当前用户起作用的，如果不加，那只针对当前的仓库起作用。
配置文件放哪了？每个仓库的Git配置文件都放在.git/config文件中：
$ cat .git/config 
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
    precomposeunicode = true
[remote "origin"]
    url = git@github.com:michaelliao/learngit.git
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master
[alias]
    last = log -1
别名就在[alias]后面，要删除别名，直接把对应的行删掉即可。
而当前用户的Git配置文件放在用户主目录下的一个隐藏文件.gitconfig中：
$ cat .gitconfig
[alias]
    co = checkout
    ci = commit
    br = branch
    st = status
[user]
    name = Your Name
    email = your@email.com
配置别名也可以直接修改这个文件，如果改错了，可以删掉文件重新通过命令配置。

小结
	给Git配置好别名，就可以输入命令时偷个懒。我们鼓励偷懒。

小结
	搭建Git服务器非常简单，通常10分钟即可完成；
	要方便管理公钥，用Gitosis；
	要像SVN那样变态地控制权限，用Gitolite。

