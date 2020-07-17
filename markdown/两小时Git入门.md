# 两小时Git入门

## 1.建立git仓库

```
$ git init
```



## 2.把文件添加到仓库

```
$ git add + filename
```



## 3.把文件提交到仓库

```
$ git commit -m "wrote a readme file"
```



## 4.查看提交结果/对比工作区和文件和仓库文件的不同之处

```
$ git status
```



## 5.比对并列出文件和仓库文件的不同之处

```
$ git diff
#如果git status告诉你有文件被修改过，用git diff可以查看修改内容。
```



## 6.Git查看历史记录

```
$ git log/git log --pretty=oneline(查看精简版)
```



## 7.退回曾经的某个版本

### 7.1 退回最新版

```
$ git reset --hard + (对应的append GPL的commit id)
$ git reset --hard HEAD^
```

用HEAD表示当前版本，上一个版本就是HEAD^，上上一个版本就是HEAD^^，当然往上100个版本写100个^比较容易数不过来，所以写成HEAD~100



### 7.2 查找所有版本append GPL的commit id

```
$ git reflog
```



### 7.3 git原理:

1.工作区（Working Directory）就是Git 创建仓库所在的目录

2版本库（Repository）工作区有一个隐藏目录.git，这个不是工作区，而是Git的版本库Git的版本库里存了很多东西，其中最重要的就是称为stage（或者叫index）的暂存区，还有Git为我们自动创建的第一个分支master，以及指向master的一个指针叫HEADgit add 实际上就是把文件修改添加到暂存区git commit 实际上就是把暂存区的所有内容提交到当前分支我们创建Git版本库时，Git自动为我们创建了唯一一个master分支，所以，现在，git commit就是往master分支上提交更改



## 8.查看工作区和版本库里面最新版本的区别

```
$ git diff HEAD -- +文件名
```



## 9.放弃对文件的更改

### 9.1 放弃对"工作区"文件的更改

```
$ git checkout -- 文件名
$ git checkout -- file
```

命令中的--很重要，没有--，就变成了“切换到另一个分支”的命令



## 9.2 放弃对"暂存区"文件的更改

```
$ git reset HEAD + 文件名
```

场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令git checkout -- file。

场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令git reset HEAD ，就回到了场景1，第二步按场景1操作。

场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退<number 7>，不过前提是没有推送到远程库。

命令git rm用于删除一个文件。如果一个文件已经被提交到版本库，那么你永远不用担心误删，但是要小心，你只能恢复文件到最新版本，你会丢失最近一次提交后你修改的内容



## 10.创建GitHub远程仓库

第1步：创建SSH Key。在用户主目录下，看看有没有.ssh目录，如果有，再看看这个目录下有没有id_rsa,id_rsa.pub这两个文件，如果已经有了，可直接跳到下一步。如果没有，打开Shell（Windows下打开Git Bash），创建SSH Key

```
$ ssh-keygen -t rsa -C"youremail@example.com"
```



第2步：登陆GitHub，打开“Account settings”，“SSH Keys”页面,然后，点“Add SSH Key”，填上任意Title，在Key文本框里粘贴id_rsa.pub文件的内容



第3步: 登陆GitHub，在右上角找到“Create a new repo”按钮，创建一个新的仓库,在Repository name填入仓库名，其他保持默认设置，点击“Create repository”按钮，就成功地创建了一个新的Git仓库



第4步: 在本地shell上 对GitHub上的仓库绑定: git remote add frelon git@github.com:lixuanliming/frelon.git 这里的 frelon 是远程仓库的名字,后面是GitHub给的URL11.推送更新到GitHub仓库上

```
$ git push -u 仓库名 master
```



\#由于远程库是空的，我们第一次推送master分支时，加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，还会把本地的master分支和远程的master分支关联起来，在以后推送或者拉取时就不用加 -u 参数

```
$ git push 仓库名 master
```



## 11. 关于远程仓库

从远程仓库克隆 如果自己需要新建一个项目,且从零开发，那么最好的方式是先创建远程库，然后，在shell里从远程库克隆

建仓库过程省略,在建立仓库的时候我们可以勾选Initialize this repository with a README，这样GitHub会自动为我们创建一个README.md文件。创建完毕后，可以看到README.md文件



## 12. Clone 远程仓库 

```
git clone git@github.com:lixuanliming/frelon.git
```



## 13.Git分支



### 13.1 创建Git分支

```
$ git checkout -b bayu git checkout -b bayu
```

-b表示branch相当于下面两条命令git branch bayu 建立'bayu'分支git check bayu 切换到'bayu'分支



### 13.2 查看分支

```
$ git branch
```

当前分支前面会标一个*号



### 13.3 合并分支到当前分支

#### 13.3.1 Fast合并分支

```
$ git merge frelon
```

注意提示的 Fast-forward 信息，Git告诉我们，这次合并是“快进模式”，也就是直接把master指向dev的当前提交，所以合并速度非常快。当然，也不是每次合并都能Fast-forward



#### 13.3.2 常规合并分支

```
$ git merge --no-ff -m "merge with no-ff" frelon
```

合并分支时，加上--no-ff参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。



### 13.4 删除多余分支

```
$ git branch -d bayu
```



### 13.5 丢弃未合并的分支

```
$ git branch -D fork1
```

假设fork1是未合并的分支,那么用13.4中的删除方法并不可行,只能用 -D强制删除查看分支：`git branch` 创建分支：`git branch` 切换分支：`git checkout` 创建+切换分支：`git checkout -b` 合并某分支到当前分支：`git merge` 删除分支：`git branch -d `



## 14. Git冲突解决

git合并时遇到的冲突问题 当Git无法自动合并分支时，就必须首先解决冲突。解决冲突后，再提交，合并完成。解决冲突就是把Git合并失败的文件手动编辑为我们希望的内容，再提交。用 `git log --graph` 命令可以看到分支合并图。



### 14.1 查看分支合并图

```
$ git log --graph
```



15.git解决bug分支的问题 修复bug时，我们会通过创建新的bug分支进行修复，然后合并，最后删除.当手头工作没有完成时，先把工作现场 `git stash` 一下，然后去修复bug，修复后，再 `git stash pop`，回到工作现场。

- 把工作区的文件暂时隐藏起来

```
$ git stash
```

- 切换到master分支下面

```
$ git checkout master
```

- 建立issue-101的修复bug的分支 "并进入该分支修复bug"

```
$ git checkout -b issue-101
```

- 把文件提交到暂存区

```
$ git add xxx.py
$ git commit -m "fix bug 101" 提交文件到仓库
```

- 回到原分支

```
$ git checkout master
```

- 删除issue-101分支

```
$ git merge --no-ff -m "merged bug fix 101" issue-101
```

- 返回原分区

```
$ git checkout dev
```

- 还原工作区

```
$ git status
```

- 继续工作

```
$ git stash pop
```



## 16 git的多人协作

### 16.1 查看远程仓库的信息

```
$ git remote -v(显示详细信息)
```



### 16.2 推送分支到远程仓库

```


$ git push origin master 这是推送主分支(origin是远程仓库的名字)

$ git push origin dev 还可以推送别的副分支(origin是远程仓库的名字)
```



### 16.3 抓取分支 从本地推送分支

使用 `git push origin branch-name`，如果推送失败，先用 `git pull`  抓取远程的新提交； 在本地创建和远程分支对应的分支，使用 `git checkout -b branch-name origin/branch-name` ，本地和远程分支的名称最好一致； 建立本地分支和远程分支的关联，使用 `git branch --set-upstream branch-name origin/branch-name` ； 从远程抓取分支，使用git pull，如果有冲突，要先处理冲突。



## 17 git标签管理

### 17.1 git创建标签

```
$ git tag tag_Name
```



### 17.2 对git已经commit过的历史文件打标签 

```
$ git log --pretty=oneline --abbrev-commit 查看log中所记录的commit id
```

```
$ git tag v0.9 f52c633 
对commit id为 f52c633 的文件打上标签为 v0.9还可以创建带有说明的标签，用-a指定标签名，-m指定说明文字
如下 实例:
$ git tag -a v0.1 -m "blabla" 1094ad
```



### 17.3 查看标签信息

```
$ git tag 查看所有 tag信息
$ git show <tagname> 查看指定tag信息
```



### 17.4 推送标签到远程

```
$ git push frelon v1.0 给某个仓库打标签
$ git push frelon --tags 一次性推送全部尚未推送到远程的本地标签,前提是本地都打了标签
```



### 17.5 删除标签

```
$ git tag -d v0.1
```

这适用于尚为推送到远程仓库使用如果标签已经推送到远程，要删除远程标签就麻烦一点，先从本地删除：

```
$ git tag -d v0.9 $ git push frelon :refs/tags/v0.9
```



命令 `git push origin` 可以推送一个本地标签；

命令 `git push origin --tags` 可以推送全部未推送过的本地标签；

命令 `git tag -d` 可以删除一个本地标签；

命令 `git push origin :refs/tags/` 可以删除一个远程标签。



### 本文参考 [廖雪峰的官方网站/Git教程](https://www.liaoxuefeng.com/wiki/896043488029600)

曾经在微信公众上也发过,但是因为公众号维护起来比较麻烦就拖到这里来了,文章写的匆忙,如有错误欢迎评论区指导/纠正