FROM python:3.7.3-slim

# 来源https://mirrors.tuna.tsinghua.edu.cn/help/debian/。版本是stretch。
# Debian 的软件源配置文件是 /etc/apt/sources.list。
# 将系统自带的该文件做个备份，将该文件替换为下面内容，即可使用 TUNA 的软件源镜像。
# 如果遇到无法拉取 https 源的情况，请先使用 http 源并安装：
COPY source_debian_stretch.list /etc/apt/sources.list

# ENV PIP_INSTALL_ARG="--default-timeout=100 --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple"
ENV PIP_INSTALL_ARG="--default-timeout=100 --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple"
# ENV PIP_INSTALL_ARG="--no-cache-dir"

# 更新系统必须的包
RUN apt update \
    && apt install -y sudo ca-certificates wget gcc make zlib1g zlib1g-dev libffi-dev git python3-tk cron \
    && rm -rf /var/lib/apt/lists/*

# 安装talib依赖项
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
    && tar -xzf ta-lib-0.4.0-src.tar.gz \
    && cd ta-lib/ \
    && ./configure --prefix=/usr \
    && make \
    && sudo make install \
    && cd .. \
    && pip --version \
    && pip3 install --upgrade pip $PIP_INSTALL_ARG \
    && pip3 install TA-Lib==0.4.17 $PIP_INSTALL_ARG \
    && rm -r ta-lib \
    && rm ta-lib-0.4.0-src.tar.gz \
    && pip --version

# 安装python需要的包
RUN pip install numpy==1.16.2 $PIP_INSTALL_ARG \
    && pip install empyrical==0.5.3 $PIP_INSTALL_ARG \
    && pip install matplotlib==3.3.2 $PIP_INSTALL_ARG \
    && pip install seaborn==0.9.0 $PIP_INSTALL_ARG \
    && pip install mplfinance==0.12.6a3 $PIP_INSTALL_ARG \
    && pip install abupy==0.4.0 $PIP_INSTALL_ARG \
    && pip install TA-Lib==0.4.17 $PIP_INSTALL_ARG \
    && pip install peakutils==1.3.3 $PIP_INSTALL_ARG \
    && pip install ipywidgets==7.4.2 $PIP_INSTALL_ARG \
    && pip install bokeh==2.0.2 $PIP_INSTALL_ARG \
    && pip install toolz==0.10.0 $PIP_INSTALL_ARG \
    # && pip install notebook $PIP_INSTALL_ARG \
    # && pip install jupyter_contrib_nbextensions $PIP_INSTALL_ARG \
    && pip install quantaxis==1.9.30 $PIP_INSTALL_ARG \
    && pip install pandas==1.0.5 $PIP_INSTALL_ARG \
    && pip uninstall -y pytdx janus \
    && pip install pytdx==1.72 janus==0.4.0 $PIP_INSTALL_ARG \
    && pip install tabulate==0.8.3 $PIP_INSTALL_ARG \
    # && pip install xlrd==1.2.0 yapf openpyxl \
    # xlsxwriter $PIP_INSTALL_ARG \
    # 启用jupyter扩展
    # && jupyter contrib nbextension install --user \
    && pip3 install --upgrade git+https://github.com/GuQiangJS/gquant.git --no-cache-dir \
    && pip3 install --upgrade git+https://github.com/GuQiangJS/abu.git --no-cache-dir


# # 配置matplotlib
# ENV matplotlibrc /usr/local/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc
# ENV mpl_path /usr/local/lib/python3.7/site-packages/matplotlib/mpl-data/

# # 复制黑体字体
# COPY simhei.ttf "$mpl_path"fonts/ttf/SimHei.ttf

# # 设置matplotlib-支持中文显示
# RUN sed -i 's/#font.family/font.family/' "$matplotlibrc" \
#     && sed -i 's/#font.sans-serif\s*:/font.sans-serif : SimHei, /' "$matplotlibrc" \
#     && sed -i 's/#axes.unicode_minus\s*:\s*True/axes.unicode_minus  : False/' "$matplotlibrc" 

# git pull 时每次都要输入用户名和密码的解决办法
RUN git config --global credential.helper store

# 设置QUANTAXIS连接MONGODB的字符串
ARG mongodb_ip="127.0.0.1"
ARG mongodb_port="27017"

RUN mkdir /root/.quantaxis/setting/ -p \
    && touch /root/.quantaxis/setting/config.ini \
    && echo "[MONGODB]" > /root/.quantaxis/setting/config.ini \
    && echo "uri = mongodb://${mongodb_ip}:${mongodb_port}" >> /root/.quantaxis/setting/config.ini

ARG git_username=""
ARG git_pwd=""
ARG git_useremail=""

# 克隆gquant-report到本地
RUN git config --global http.proxy http://172.16.2.146:1080 \
    && git config --global https.proxy https://172.16.2.146:1080 \
    && git clone https://${git_username}:${git_pwd}@github.com/guqiangjs/gquant-report.git/

# 设置时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shangshai" > /etc/timezone

# 复制需要的数据，数据来源 https://github.com/bbfamily/abu/tree/master/abupy/RomDataBu
COPY stock_code_CN.csv /usr/local/lib/python3.7/site-packages/abupy/RomDataBu/stock_code_CN.csv

# Copy hello-cron file to the cron.d directory
COPY dailyauto-cron /etc/cron.d/dailyauto
COPY dailyauto.sh /dailyauto.sh

# git pull 时每次都要输入用户名和密码的解决办法
RUN git config --global credential.helper store

RUN git config --global user.email "${git_useremail}" \
    && git config --global user.name "${git_username}"

# 因为要使用到构造参数，所以必须用双引号包裹 sed 的参数。
# https://stackoverflow.com/questions/54075585/run-sed-in-dockerfile-to-replace-text-with-build-arg-value
RUN sed -i "s/{username}/${git_username}/" /dailyauto.sh \
    && sed -i "s/{pwd}/${git_pwd}/" /dailyauto.sh

# COPY daily_creator.py /daily_creator.py

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/dailyauto \
    && crontab /etc/cron.d/dailyauto

# Run the command on container startup
CMD cron -f && tail -f /dailyauto.log