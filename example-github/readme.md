本示例展示如何自动在容器内克隆github项目，并对项目内容进行修改后，再提交。

构建示例：

```bash
$ docker build -q -t abc . --build-arg git_username=github用户名 --build-arg git_pwd=github密码 --build-arg git_useremail=邮箱
sha256:637096d2184867262e7505ca8391868ce251f368897b9ac97cb1688dd9a104f1
$ docker run -it --name abc abc
[master 099fff5] 测试
 1 file changed, 1 insertion(+)
Pushing to https://github用户名:github密码@github.com/GuQiangJS/temp.git
Counting objects: 3, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 302 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
POST git-receive-pack (455 bytes)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/GuQiangJS/temp.git
   9479b54..099fff5  master -> master
```