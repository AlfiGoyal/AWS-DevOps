FROM ubuntu:xenial
LABEL maintainer="Alfi Goyal"
LABEL email="goya8893@stthomas.edu"
EXPOSE 8080
RUN apt-get update -y && \
    apt-get install -y python-pip && \
    apt-get install -y python-dev
COPY app/* /app/
WORKDIR /app
RUN pip install -r requirements.txt
CMD ["site.py"]
ENTRYPOINT ["python"]
