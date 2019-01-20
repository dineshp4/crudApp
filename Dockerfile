FROM tomcat
WORKDIR /usr/local/tomcat
COPY *.war /usr/local/tomcat/webapps/.
CMD ["catalina.sh", "run"]
EXPOSE 8080
