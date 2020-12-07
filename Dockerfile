FROM centos
RUN yum update -y \
    && yum install sudo -y \
    && sudo yum install python36 wget gcc gcc-c++ make python3-devel llvm llvm-devel git-all tk-devel tcl-devel sqlite-devel gdbm-devel xz-devel readline-devel python3-tkinter net-tools firewalld -y \
    && wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
    && tar -xzf ta-lib-0.4.0-src.tar.gz \
    && cd ta-lib/ \
    && ./configure --prefix=/usr \
    && make \
    && sudo make install \
    && cd .. \
    && pip3 install empyrical==0.5.3 \
    && pip3 install matplotlib==3.3.2" \
    && pip3 install pandas==1.0.5" \
    && pip3 install seaborn==0.9.0" \
    && pip3 install mplfinance==0.12.6a3" \
    && pip3 install abupy==0.4.0" \
    && pip3 install TA-Lib==0.4.17" \
    && pip3 install quantaxis==1.9.30" \
    && pip3 install peakutils==1.3.3" \
    && pip3 install ipywidgets==7.4.2" \
    && pip3 install bokeh==2.0.2" \
    && pip3 install toolz==0.10.0" \
    && pip3 install notebook" \
    && pip3 install jupyter_contrib_nbextensions" \
    && pip3 install yapf" \
    && pip3 install -r req.txt \
    && pip3 unstall pytdx -y \
    && pip3 install pytdx==1.72 \
    && pip3 install --upgrade git+https://github.com/GuQiangJS/gquant.git \
    && pip3 uninstall janus -y \
    && pip3 install janus==0.4.0 \
    && jupyter contrib nbextension install --user \
