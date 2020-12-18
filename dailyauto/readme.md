# 说明

* 基于 [python3.7.3-slim](https://hub.docker.com/layers/python/library/python/3.7.3-slim/images/sha256-8baf9805da02f00e4e668ae96850107903c7201cad0350380bbbbbf38846f293) 构建的适用于 gquant 的每日自动更新、分析、生成结果、上传github的环境。其中`python`版本为`3.7.3`。启动后默认运行 `cron -f`。

  > 此版本是基于 `debian`的`stretch`版本构建。构建时会自动将`/etc/apt/sources.list`修改为[清华大学的开源镜像](https://mirrors.tuna.tsinghua.edu.cn/help/debian/)。

> （因为COPY 和 ADD 命令不能拷贝上下文之外的本地文件）。所以将所有需要的文件均放在本目录下。

* 根据 `dailyauto-cron` 文件的设定，会在每天 18:30 分执行 `dailyauto.sh`。并且会将执行日志 `append` 至容器根目录下的 `dailyauto.log` 文件中。

# 构造时参数

* **mongodb_ip**: QUANTAXIS需要使用的MONGODB所在的IP。默认为127.0.0.1。
* **mongodb_port**：QUANTAXIS需要使用的MONGODB所在的Port。默认为27017。
* **git_username**: 克隆 `http://github.com/guqiangjs/gquant-report.git` 时使用的用户名。(**必须**)。
* **git_pwd**: 克隆 `http://github.com/guqiangjs/gquant-report.git` 时使用的密码。(**必须**)。
* **git_useremail**: 提交 `http://github.com/guqiangjs/gquant-report.git` 时使用的用户Email。(**必须**)。

```bash
$ docker build -t gquant --build-arg mongodb_ip=1.2.3.4 --build-arg git_username=用户名 --build-arg git_pwd=密码 --build-arg git_useremail=电子邮箱 .

$ docker run -it gquant /bin/bash
root@21612463eae6:/# cat /root/.quantaxis/setting/config.ini
[MONGODB]
uri = mongodb://1.2.3.4:27017
root@21612463eae6:/#
```

> git pull 时每次都要输入用户名和密码的解决办法
> 
> 如果我们git clone的下载代码的时候是连接的https://而不是git@git (ssh)的形式，当我们操作git pull/push到远程的时候，总是提示我们输入账号和密码才能操作成功，频繁的输入账号和密码会很麻烦。
> 
> 解决办法：
> 
> git bash进入你的项目目录，输入：
> 
> git config --global credential.helper store
> 
> 然后你会在你本地生成一个文本，上边记录你的账号和密码。当然这些你可以不用关心。
> 
> 然后你使用上述的命令配置好之后，再操作一次git pull，然后它会提示你输入账号密码，这一次之后就不需要再次输入密码了。