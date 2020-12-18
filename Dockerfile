FROM registry.cn-shanghai.aliyuncs.com/lian_ns/python:3.6
MAINTAINER gaoyang
ENV TZ "Asia/Shanghai"

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

COPY ./test_dj /opt/test_dj
WORKDIR /opt/test_dj

ENTRYPOINT ["sh"]
CMD ["-h"]
EXPOSE 8000
