# 每日自动更新、分析、生成结果、上传github的脚本
cd /gquant-report

# 更新代码
/usr/bin/git pull

echo "开始每日更新数据。$(date)"
# 更新数据
/usr/local/bin/python /gquant-report/update_data.py
# 获取最新
/usr/bin/git pull origin master
# 创建数据
/usr/local/bin/python /gquant-report/daily_creator.py

#周内效应
/usr/local/bin/python /gquant-report/calendar_effect/create_baseline.py
/usr/local/bin/python /gquant-report/calendar_effect/daily_creator.py

# 备份数据
TODAY=$(date +"%Y-%m-%d")
cp /gquant-report/readme.md /gquant-report/history/$TODAY.md
# 附加持仓
/usr/local/bin/python /gquant-report/write_holds.py
/usr/bin/git add /gquant-report/readme.md
/usr/bin/git add /gquant-report/history/$TODAY.md
/usr/bin/git add /gquant-report/imgs/
/usr/bin/git add /gquant-report/calendar_effect/
# 上传数据
/usr/bin/git commit -v -m "$TODAY"
#/usr/bin/git push -v http://{username}:{pwd}@github.com/GuQiangJS/gquant-report.git --all

RETIRES=5
COUNT=1
while [ ${COUNT} -lt ${RETIRES} ]; 
do
  /usr/bin/git push
  if [ $? -eq 0 ]; then
    echo $?
    RETRIES=0
    break
  fi
  let COUNT=${COUNT}+1
  sleep 10
done
echo "完成每日更新数据。$(date)"
echo "---------------------------------------"
