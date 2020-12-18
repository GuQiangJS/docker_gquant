FROM python:3.7.3-slim

RUN apt-get update && apt-get -y install git ca-certificates

# git pull 时每次都要输入用户名和密码的解决办法
RUN git config --global credential.helper store

COPY /run.sh /run.sh

# 下载gquant-report
ARG git_username=""
ARG git_pwd=""
ARG git_useremail=""

# 当有username和password时克隆gquant-report到本地
RUN git clone https://${git_username}:${git_pwd}@github.com/GuQiangJS/temp.git

RUN git config --global user.email "${git_useremail}" \
    && git config --global user.name "${git_username}"

# 因为要使用到构造参数，所以必须用双引号包裹 sed 的参数。
# https://stackoverflow.com/questions/54075585/run-sed-in-dockerfile-to-replace-text-with-build-arg-value
RUN sed -i "s/{username}/${git_username}/" /run.sh \
    && sed -i "s/{pwd}/${git_pwd}/" /run.sh

# 以下为运行示例

CMD /run.sh