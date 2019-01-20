FROM tomcat
WORKDIR /usr/local/tomcat
COPY target/crud*.war ./webapps/.
CMD ["catalina.sh", "run"]
EXPOSE 8080
