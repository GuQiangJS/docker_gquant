cd /temp
/bin/echo $(date) >> docker_example
/usr/bin/git add .
/usr/bin/git commit -m "测试"
/usr/bin/git push -v https://{username}:{pwd}@github.com/GuQiangJS/temp.git --all