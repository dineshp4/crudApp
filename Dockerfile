FROM tomcat
WORKDIR /usr/local/tomcat
RUN yum -y install wget
CMD ["catalina.sh", "run"]
EXPOSE 8080
