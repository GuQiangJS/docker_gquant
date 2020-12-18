本示例展示如何创建一个每分钟定时执行的任务。

容器运行后会自动每隔一分钟向根目录下的`daily.log`文件中打印一行当前时间。

调用路径为 `dailyauto-cron`->`dailyauto.sh`->`dailyauto.py`。

```bash
$ docker build -q -t abc .
sha256:a410c4e94e1c5d496ebdece76acbaaa841d6c56604932fc1c4ef3aafdb0d97fe
$ docker run -itd abc
b71b6d43a490a2acd9444efe54e0ef273e54bae875380d3e5d4ad4a226223f28
$ docker ps -a
CONTAINER ID  IMAGE  COMMAND                 CREATED              STATUS             PORTS   NAMES
b71b6d43a490  abc   "/bin/sh -c 'cron -f'"   About a minute ago   Up About a minute          clever_napier
$ docker exec clever_napier cat /dailyauto.log
2020-12-16 09:12:01.395286
2020-12-16 09:13:01.425692
$ docker exec clever_napier cat /dailyauto.log
2020-12-16 09:12:01.395286
2020-12-16 09:13:01.425692
2020-12-16 09:14:01.460776
```