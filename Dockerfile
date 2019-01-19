FROM tomcat
WORKDIR /usr/local/tomcat
COPY target/crudApp.war /usr/local/tomcat/webapps/.
CMD ["catalina.sh", "run"]
EXPOSE 8080
