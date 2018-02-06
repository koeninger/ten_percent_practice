FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum -y --setopt=tsflags=nodocs install nano && \
    yum -y --setopt=tsflags=nodocs install php56w && \
    yum -y --setopt=tsflags=nodocs install php56w-common && \ 
    yum clean all

EXPOSE 80

#COPY files/httpd.conf /etc/httpd/conf/httpd.conf
COPY files/test.test.conf /etc/httpd/sites-enabled/test.test.conf

# Simple startup script to avoid some issues observed with container restart
ADD files/run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
