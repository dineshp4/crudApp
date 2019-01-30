FROM tomcat
WORKDIR /usr/local/tomcat
RUN apt-get -y install wget
RUN wget http://10.0.1.13:8081/repository/maven-releases/maven-Central/crudApp/1.${BUILD_NUMBER}/crudApp-1.${BUILD_NUMBER}.war -O webapps/crudApp.war
CMD ["catalina.sh", "run"]
EXPOSE 8080
