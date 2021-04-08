# 说明

* 基于 [python3.7.3-slim](https://hub.docker.com/layers/python/library/python/3.7.3-slim/images/sha256-8baf9805da02f00e4e668ae96850107903c7201cad0350380bbbbbf38846f293) 构建的适用于 gquant holding—crack 的python环境。其中`python`版本为`3.7.3`。启动后默认在5000端口上运行 `flask`。

  > 此版本是基于 `debian`的`stretch`版本构建。构建时会自动将`/etc/apt/sources.list`修改为[清华大学的开源镜像](https://mirrors.tuna.tsinghua.edu.cn/help/debian/)。

# 构造时参数

* **mongodb_ip**: QUANTAXIS需要使用的MONGODB所在的IP。默认为127.0.0.1。
* **mongodb_port**：QUANTAXIS需要使用的MONGODB所在的Port。默认为27017。
* **git_username**: 克隆 `http://github.com/guqiangjs/gquant-report.git` 时使用的用户名。(**必须**)。
* **git_pwd**: 克隆 `http://github.com/guqiangjs/gquant-report.git` 时使用的密码。(**必须**)。

```bash
$ docker build -t websit --build-arg mongodb_ip=1.2.3.4 --build-arg git_username=用户名 --build-arg git_pwd=密码 .

$ docker run -it --name website -p 80:80 -p 5000:5000 website
2020-12-18 10:48:05: (log.c.217) server started
 * Serving Flask app "/holding_tracking/server/hello.py"
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
Generating new fontManager, this may take some time...
you are using non-interactive mdoel quantaxis
 * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
```

~~* 2020-12-18：貌似ant-ng-zorro相关的样式无法加载，造成网页显示很烂，所以暂时作为web服务器使用。~~

~~# 待处理~~

## 更新网站

1. 进入运行中的容器
```bash
docker exec -it website /bin/sh
```

2. pgrep命令不存在时的解决方案
```bash
apt-get install procps
```

3. 重新编译网站
```bash
cd holding_tracking
git pull
cd client
ng build --prod
```

4. 重启网站服务
```bash
kill $(pgrep -f flask)
/bin/bash /holding_tracking/server/start.sh
```

## 更新文件

每年需要更新交易日信息，该信息包含在`QUANTAXIS/QAUtil/QADate_trade.py`文件中。

如下示例表示

* -N 替换原有文件
* -P 指定下载目标目录，替换原本的`QADate_trade.py`
* -e 使用指定代理

`wget -N -P /usr/local/lib/python3.7/site-packages/QUANTAXIS/QAUtil/ https://raw.githubusercontent.com/QUANTAXIS/QUANTAXIS/master/QUANTAXIS/QAUtil/QADate_trade.py -e use_proxy=yes -e https_proxy=127.0.0.1:1080`
