FROM tomcat
WORKDIR /usr/local/tomcat
RUN yum install wget -y
RUN wget http://18.223.24.241:8081/repository/maven-releases/maven-Central/crudApp/1.${BUILD_NUMBER}/crudApp-1.${BUILD_NUMBER}.war -O /usr/local/tomcat/webapps/crudApp.war
CMD ["catalina.sh", "run"]
EXPOSE 8080
